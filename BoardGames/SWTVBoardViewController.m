//
//  SWTVBoardViewController.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWTVBoardViewController.h"

@interface SWTVBoardViewController ()

@end

@implementation SWTVBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentDieValue = 1;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.containerView.backgroundColor = [UIColor purpleColor];
    self.boardImageView.backgroundColor = [UIColor blueColor];
    
    self.currentSquareIndex = -1;
    self.boardImageView.layer.minificationFilter = kCAFilterNearest;
    
    self.containerView.hidden = TRUE;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueGameplay) name:@"SWUserPressedContinue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollDice) name:@"SWUserPressedRoll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBoard:) name:@"SWLoadNewBoard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBackATurn:) name:@"SWGoBackATurn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipTurn:) name:@"SWSkipTurn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollWithoutMoving:) name:@"SWRollWithoutMoving" object:nil];
    
    if ([self isiPad]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitingForContinue) name:@"SWWaitingForContinue" object:nil];
        UISwipeGestureRecognizer *swipeDieLR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rollDice)];
        [swipeDieLR setDirection:UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionUp];
        [self.dieImageView addGestureRecognizer:swipeDieLR];
        UISwipeGestureRecognizer *swipeDieUD = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rollDice)];
        [swipeDieUD setDirection:UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown];
        [self.dieImageView addGestureRecognizer:swipeDieUD];
        
        UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapPlayer:)];
        
        // Set required taps and number of touches
        [oneFingerTwoTaps setNumberOfTapsRequired:2];
        [oneFingerTwoTaps setNumberOfTouchesRequired:1];
        
        // Add the gesture to the view
        [self.sideboard addGestureRecognizer:oneFingerTwoTaps];
        
    }
}

- (void)doubleTapPlayer:(UITapGestureRecognizer *)recognizer
{
    if (!self.rollAction) return;
    
    NSInteger playerIndex = (NSInteger)[recognizer locationInView:self.sideboard].y / 100;
    NSLog(@"Double tapped player %d", playerIndex);
    
    if (playerIndex >= self.match.players.count) return;
    
    NSInteger currentTurn = self.match.turnNumber % self.match.players.count;
    if (currentTurn == playerIndex) return;
    
    if (currentTurn > playerIndex) self.match.turnNumber -= (currentTurn - playerIndex);
    if (currentTurn < playerIndex) self.match.turnNumber += (playerIndex - currentTurn);

    SWPlayer *player = [self.match.players objectAtIndex:playerIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SWWaitingForRoll" object:player userInfo:nil];
    [self updateSideboard];

}

- (void)waitingForContinue
{
    self.continueButton.alpha = 1.0;
    self.continueButton.enabled = TRUE;
}
- (IBAction)continuePressed:(id)sender
{
    self.continueButton.alpha = 0.4;
    self.continueButton.enabled = FALSE;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWUserPressedContinue" object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self isiPad] && self.match){
        [self loadMatch:self.match];
        
        [self waitForRollWithNextAction:^{
            [self autoTurns];
        }];
    }

    if (!self.match || self.match == (id)[NSNull null]){
        CGSize viewSize = self.view.frame.size;
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(-viewSize.width, -viewSize.height, viewSize.width*3, viewSize.height*3)];
        messageLabel.text = @"Please Choose a Game.";
        messageLabel.font = [UIFont systemFontOfSize:80];
        messageLabel.backgroundColor = [UIColor blackColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:messageLabel];
        self.messageOverlay = messageLabel;
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)goBackATurn:(NSNotification *)notification
{
    NSLog(@"Go back a turn");
    self.match.turnNumber--;
    [self updateSideboard];
    NSInteger playerTurn = self.match.turnNumber % self.match.players.count;
    SWPlayer *player = [self.match.players objectAtIndex:playerTurn];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SWWaitingForRoll" object:player userInfo:nil];
}

- (void)skipTurn:(NSNotification *)notification
{
    NSLog(@"Skip Turn");
    self.match.turnNumber++;
    [self updateSideboard];
    NSInteger playerTurn = self.match.turnNumber % self.match.players.count;
    SWPlayer *player = [self.match.players objectAtIndex:playerTurn];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SWWaitingForRoll" object:player userInfo:nil];
}

- (void)rollWithoutMoving:(NSNotification *)notification
{
    NSLog(@"roll without moving");
    [self animateDieRollWithCompleted:nil];
}

- (void)loadBoard:(NSNotification *)notification
{
    NSLog(@"Loading board.");
    if (!notification.object) return;
    NSString *boardPlistName = [notification.object objectForKey:@"boardName"];
    
    SWBoard *pokeBoard = [SWBoard boardWithPlistNamed:boardPlistName];
    
    SWMatch *match = [SWMatch matchWithBoard:pokeBoard];
    match.players = [notification.object objectForKey:@"players"];
    
    [self loadMatch:match];
    
    [self waitForRollWithNextAction:^{
        [self autoTurns];
    }];
}

//////////// TEST METHODS /////////////////
- (void)goToNextSquare:(NSTimer *)timer
{
    if (self.currentSquareIndex + 1 >= self.board.squares.count){
        [timer invalidate];
        [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(goToRandomSquare:) userInfo:nil repeats:TRUE];
    } else {
        [self zoomToBoardSquareIndex:self.currentSquareIndex + 1 withCompleted:nil];
    }
}

- (void)autoTurns
{
    NSLog(@"Autoturn");
    NSInteger playerTurn = self.match.turnNumber % self.match.players.count;
    SWPlayer *player = [self.match.players objectAtIndex:playerTurn];
    self.match.turnNumber++;
    
    
    if (player.currentSquareIndex == self.board.squares.count - 1){
        NSLog(@"Player %d Finished!", playerTurn);
        [self autoTurns];
    } else {
        [self animateDieRollWithCompleted:^{
            NSLog(@"ADie %d", self.currentDieValue);
            NSInteger endIndex = player.currentSquareIndex + self.currentDieValue;
            [self walkPlayer:player toSquareIndex:endIndex withCompleted:^{
                NSLog(@"Done Walking.");
                SWBoardSquare *endSquare = [self.board.squares objectAtIndex:player.currentSquareIndex];
                
                if (endSquare.switchToPikachu){
                    [player setTokenPokemon:SWPokemonPikachu];
                }
                
                //This sucks. Basically, they're duplicated.
                if (endSquare.teleportToSquareIndex != -1){
                    [self movePlayer:player toSquareIndex:endSquare.teleportToSquareIndex withCompleted:^{
                        [self zoomInOnSquareIndex:player.currentSquareIndex fadePlayersAndThenZoomOutWithCompleted:^{
                            NSLog(@"Done Zooming.");
                            [self waitForRollWithNextAction:^{
                                [self autoTurns];
                            }];
                        }];
                    }];
                } else {
                    [self zoomInOnSquareIndex:player.currentSquareIndex fadePlayersAndThenZoomOutWithCompleted:^{
                        NSLog(@"Done Zooming.");
                        [self waitForRollWithNextAction:^{
                            [self autoTurns];
                        }];
                    }];
                }
            }];
        }];
    }
}

- (void)separateOverlappingPlayers
{
    NSMutableDictionary *matches = [NSMutableDictionary new];
    for (SWPlayer *player in self.match.players) {
        NSNumber *playerSquareNumber = [NSNumber numberWithInt:player.currentSquareIndex];
        if (![matches objectForKey:playerSquareNumber]){
            [matches setObject:[NSMutableArray new] forKey:playerSquareNumber];
        }
        [(NSMutableArray *)[matches objectForKey:playerSquareNumber] addObject:player];
    }
    
    [matches enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSMutableArray *players = (NSMutableArray *)obj;
        if (players.count == 1) {
            NSLog(@"No Match.");
        } else {
            for (int i = 0; i < players.count; i++){
                SWPlayer *player = [players objectAtIndex:i];
                CGRect oldFrame = player.token.frame;
                player.token.frame = CGRectMake(oldFrame.origin.x - 20 + 20*i, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
            }            
            NSLog(@"Match!");
        }        
    }];
}


- (void)animateDieRollWithCompleted:(void (^)())block;
{
    if (block) self.rollAnimationCompleteAction = block;
    NSInteger number = arc4random()%6 + 1;
    self.currentDieValue = number;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dieImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", number]];
    });
    NSLog(@"Die %d", self.currentDieValue);
    NSInteger rotations = 1;
    CGFloat duration = 0.25;
    NSInteger repeatCount = 2;
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeatCount;
    rotationAnimation.delegate = self;
    rotationAnimation.removedOnCompletion = FALSE;
    
    [self.dieImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];    
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    if (animation == [self.dieImageView.layer animationForKey:@"rotationAnimation"]){
        [self.dieImageView.layer removeAnimationForKey:@"rotationAnimation"];
        if (self.rollAnimationCompleteAction){
            SWActionCallbackBlock action = self.rollAnimationCompleteAction;
            self.rollAnimationCompleteAction = nil;
            action();
        }
    }
}



- (void)zoomInOnSquareIndex:(NSInteger)index fadePlayersAndThenZoomOutWithCompleted:(void (^)())block;
{
    [self zoomToBoardSquareIndex:index withCompleted:^{
        [self waitForContinueWithNextAction:^{
            [self zoomToFitBoardWithCompleted:block];
        }];
    }];
}

- (void)goToRandomSquare:(NSTimer *)timer
{
    NSInteger newSquareIndex = arc4random() % self.board.squares.count;
    [self zoomToBoardSquareIndex:newSquareIndex withCompleted:nil];
}

///////////////////////////////////////////

- (void)updateSideboardFrame
{
    if ([self isiPad]) return;
    
    self.sideboard.frame = CGRectMake(0, 0, self.view.frame.size.width/5.0, self.view.frame.size.height);
    self.dieImageView.frame = CGRectMake(self.sideboard.frame.size.width/2 - 64.0, self.dieImageView.frame.origin.y, 128.0, 128.0);
}

- (void)updateSideboard
{
    if (!self.match) return;
    [self.view bringSubviewToFront:self.sideboard];
        
    [self updatePlayerLabels];

}

- (void)loadMatch:(SWMatch *)match
{
    self.containerView.hidden = FALSE;
    [self.messageOverlay removeFromSuperview];
    self.messageOverlay = nil;
    
    self.match = match;
    self.board = match.board;
    self.boardImageView.image = self.board.boardImage;
    CGSize boardSize = self.board.boardImage.size;

    self.containerView.frame = [self boardRectForScale:[self boardFitZoomScale] centeredOnCoordinate:CGPointMake(floor(boardSize.width/2), floor(boardSize.height/2))];
    
    for (SWPlayer *player in match.players) {
        player.token.frame = [self tokenFrameForSquareIndex:0];
        [self.containerView addSubview:player.token];
    }
    
    [self updateSideboardFrame];
    [self updateSideboard];
}

- (void)updatePlayerLabels
{
    NSInteger playerTurn = self.match.turnNumber % self.match.players.count;
    for (UILabel *label in self.playerLabels){
        [label removeFromSuperview];
    }
    
    self.playerLabels = [NSMutableArray new];
    for (int i = 0; i < self.match.players.count; i++){
        SWPlayer *player = [self.match.players objectAtIndex:i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0 + 100*i, self.sideboard.frame.size.width, 100)];
        label.text = player.name;
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:40.0];
        
        if (i == playerTurn){
            label.layer.borderWidth = 2.0;
            label.layer.borderColor = [UIColor whiteColor].CGColor;
            if (TRUE || [player.tokenColor isEqual:[UIColor blackColor]]){
                label.textColor = [UIColor whiteColor];
                label.shadowColor = [UIColor darkGrayColor];
                label.shadowOffset = CGSizeMake(0.0, 2.0);
            } else {
                label.textColor = [UIColor blackColor];
                label.shadowColor = [UIColor whiteColor];
                label.shadowOffset = CGSizeMake(0.0, 2.0);
            }
            label.backgroundColor = [player.tokenColor colorWithAlphaComponent:1.0];
        } else {
            label.backgroundColor = [player.tokenColor colorWithAlphaComponent:0.2];
        }
        [self.playerLabels addObject:label];
        [self.sideboard addSubview:label];
    }
    
}



- (void)movePlayer:(SWPlayer *)player toSquareIndex:(NSInteger)index withCompleted:(void (^)())block;
{
    if (!self.board || !self.board.squares || self.board.squares.count <= index) return;

    
    
    //NSLog(@"Index %d Scale %f, going to point %@", index, currentScale, NSStringFromCGPoint(newCoordinate));
    
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         player.token.frame = [self tokenFrameForSquareIndex:index];
                     }
                     completion:^(BOOL finished){
                         if (block) block();
                     }];
    player.currentSquareIndex = index;
}

- (void)waitForContinueWithNextAction:(void (^)())block
{
    self.continueAction = block;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWWaitingForContinue" object:nil];
}

- (void)continueGameplay
{
    if (self.continueAction){
        SWActionCallbackBlock action = self.continueAction;
        self.continueAction = nil;
        action();
    }
}

- (void)waitForRollWithNextAction:(void (^)())block
{
    [self updateSideboard];
    self.rollAction = block;
    NSInteger playerTurn = self.match.turnNumber % self.match.players.count;
    SWPlayer *player = [self.match.players objectAtIndex:playerTurn];
    [self.containerView bringSubviewToFront:player.token];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SWWaitingForRoll" object:player userInfo:nil];
}

- (IBAction)rollButtonPressed:(id)sender
{
    NSLog(@"here.");
    [self rollDice];
}

- (void)rollDice
{
    if (self.rollAction){
        SWActionCallbackBlock action = self.rollAction;
        self.rollAction = nil;
        action();
    } else if (self.continueAction) {
        [self rollWithoutMoving:nil];
    }
}



- (CGRect)tokenFrameForSquareIndex:(NSInteger)index
{
    CGFloat currentScale = self.containerView.frame.size.height / self.board.boardImage.size.height;
    return [self tokenFrameForSquareIndex:index withScale:currentScale];
}

- (CGRect)tokenFrameForSquareIndex:(NSInteger)index withScale:(CGFloat)scale
{
    SWBoardSquare *square = [self.board.squares objectAtIndex:index];
    
    CGPoint newCoordinate = CGPointMake(square.centerCoordinate.x, self.boardImageView.image.size.height - square.centerCoordinate.y);
    CGPoint convertedSquareCoord = CGPointMake(newCoordinate.x * scale, newCoordinate.y * scale);
    CGFloat tokenWidth = 56.0;
    return CGRectMake(convertedSquareCoord.x - floor(tokenWidth/2), convertedSquareCoord.y - floor(tokenWidth/2), tokenWidth, tokenWidth);
}

- (void)walkPlayer:(SWPlayer *)player toSquareIndex:(NSInteger)index withCompleted:(void (^)())block;
{
    if (player.currentSquareIndex + 1 >= self.board.squares.count) {
        if (block) block();
    }
    NSInteger currentSquareIndex = player.currentSquareIndex;
    
    if (currentSquareIndex != index){
        [self movePlayer:player toSquareIndex:currentSquareIndex + 1 withCompleted:^{
            SWBoardSquare *newUserSquare = [self.board.squares objectAtIndex:currentSquareIndex + 1];
            if (newUserSquare.playerMustStopHere){
                if (block) block();
            } else {
                [self walkPlayer:player toSquareIndex:index withCompleted:block];
            }
        }];
    } else {
        //finished moving
        if (block) block();
    }

}

- (void)zoomToBoardSquareIndex:(NSInteger)index withCompleted:(void (^)())block;
{
    if (!self.board || !self.board.squares || self.board.squares.count <= index) return;
    
    SWBoardSquare *square = [self.board.squares objectAtIndex:index];
    NSLog(@"center: %@", NSStringFromCGPoint(square.centerCoordinate));
    
    if (abs(self.currentSquareIndex - index) > 1){
        [self zoomToFitBoardWithCompleted:^{
            [self zoomToHeight:square.bounds.size.height*1.6 centeredOnBoardCoordinate:square.centerCoordinate withCompleted:block];
        }];
    } else {
        [self zoomToHeight:square.bounds.size.height*1.6 centeredOnBoardCoordinate:square.centerCoordinate withCompleted:block];
    }
    self.currentSquareIndex = index;
}




- (void)zoomToHeight:(CGFloat)height centeredOnBoardCoordinate:(CGPoint)boardCoord withCompleted:(void (^)())block
{
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat heightToScreenScale = screenHeight/height;
    
    [self zoomToScale:heightToScreenScale centeredOnBoardCoordinate:boardCoord withCompleted:block];
}


- (void)zoomToScale:(CGFloat)scale centeredOnBoardCoordinate:(CGPoint)boardCoord withCompleted:(void (^)())block
{
    [UIView animateWithDuration:1.0f
                     animations:^{
                         self.containerView.frame = [self boardRectForScale:scale centeredOnCoordinate:boardCoord];
                         
                         if (!self.match || !self.match.players || self.match.players.count == 0) return;
                         for (SWPlayer *player in self.match.players){
                             player.token.frame = [self tokenFrameForSquareIndex:player.currentSquareIndex withScale:scale];
                             
                         }
                     }
                     completion:^(BOOL finished){
                         //NSLog(@"Done. Scale: %f, Image Frame: %@", scale, NSStringFromCGRect(self.containerView.frame));
                         if (block) block();
                     }];
}

- (void)zoomToFitBoardWithCompleted:(void (^)())block
{
    CGSize imageSize = self.boardImageView.image.size;
    [self zoomToScale:[self boardFitZoomScale] centeredOnBoardCoordinate:CGPointMake(floor(imageSize.width/2), floor(imageSize.height/2)) withCompleted:block];
}

- (CGRect)boardRectForScale:(CGFloat)scale centeredOnCoordinate:(CGPoint)boardCoord
{
    CGSize viewSize = self.view.frame.size;
    CGSize boardSize = self.boardImageView.image.size;
    
    boardCoord = [self flipCoordinateAxis:boardCoord];
    CGPoint convertedBoardOffset = CGPointMake(boardCoord.x * scale, boardCoord.y * scale);
    NSLog(@"Viewsize is %f %f, board is %f %f, center on %f %f", viewSize.width, viewSize.height, boardSize.width, boardSize.height, convertedBoardOffset.x, convertedBoardOffset.y);

    
    NSLog(@"Sideboard is %f wide, view is %f wide", self.sideboard.frame.size.width, self.view.frame.size.width);
    [self updateSideboardFrame];
    CGFloat newX;
    CGFloat newY;
    
    NSLog(@"ORIENTATION: %d %d %d", self.interfaceOrientation,  [[UIDevice currentDevice] orientation],  [[UIApplication sharedApplication] statusBarOrientation]);
    if ([self isiPad] && viewSize.width != 1024.0){
        newX = (viewSize.height/2 - (boardSize.width * scale)) + convertedBoardOffset.x + self.sideboard.frame.size.width/2;
        newY = ((viewSize.width/2 - (boardSize.height * scale))) + convertedBoardOffset.y;
    } else {
        newX = (viewSize.width/2 - (boardSize.width * scale)) + convertedBoardOffset.x + self.sideboard.frame.size.width/2;
        newY = ((viewSize.height/2 - (boardSize.height * scale))) + convertedBoardOffset.y;
    }
    

    CGFloat newWidth = boardSize.width*scale;
    CGFloat newHeight = boardSize.height*scale;
    
    NSLog(@"Board rect for scale %f: %@", scale, NSStringFromCGRect(CGRectMake(floorf(newX), floorf(newY), floorf(newWidth), floorf(newHeight))));
    
    return CGRectMake(floorf(newX), floorf(newY), floorf(newWidth), floorf(newHeight));
}

- (CGFloat)boardFitZoomScale
{
    CGSize viewSize = self.view.frame.size;
    CGSize boardSize = self.boardImageView.image.size;

    CGFloat widthScale = viewSize.width / boardSize.width ;
    CGFloat heightScale = viewSize.height / boardSize.height;

    
    //we want the smaller one, because that is *more* zoomed out
    CGFloat fitScale = fminf(widthScale, heightScale);
    
    //NSLog(@"scale: %f %f -> %f", widthScale, heightScale, fitScale);
        
    return fitScale;
}


- (CGPoint)flipCoordinateAxis:(CGPoint)point
{
    return CGPointMake(self.boardImageView.image.size.height - point.x, point.y);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}



- (BOOL)isiPad {
    return (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad);
}

@end
