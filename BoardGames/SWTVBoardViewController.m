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
    self.view.backgroundColor = [UIColor blackColor];
    self.containerView.backgroundColor = [UIColor purpleColor];
    self.boardImageView.backgroundColor = [UIColor blueColor];
    
    self.currentSquareIndex = -1;
    self.boardImageView.layer.minificationFilter = kCAFilterTrilinear;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueGameplay) name:@"SWUserPressedContinue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollDice) name:@"SWUserPressedRoll" object:nil];
    

    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SWBoard *pokeBoard = [SWBoard boardWithPlistNamed:@"pokemon"];
    
    /*
    SWBoard *pokeBoard = [SWBoard boardWithImage:[UIImage imageNamed:@"PokemonBoard"]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 294.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 482.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 670.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 858.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 1046.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 1234.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 1422.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 1610.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(296.0, 1798.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 1798.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 1798.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(858.0, 1798.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1046.0, 1798.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1234.0, 1798.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 1798.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 1798.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 1798.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 1610.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 1422.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 1234.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 1046.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 858.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 670.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 482.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1798.0, 294.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 294.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 294.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1234.0, 294.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1046.0, 294.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(858.0, 294.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 294.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 294.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 482.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 670.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 858.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 1046.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 1234.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 1422.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(482.0, 1610.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 1610.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(858.0, 1610.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1046.0, 1610.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1234.0, 1610.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 1610.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 1610.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 1422.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 1234.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 1046.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 858.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 670.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1610.0, 482.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 482.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1234.0, 482.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1046.0, 482.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(858.0, 482.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 482.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 670.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 858.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 1046.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 1234.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(670.0, 1422.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(858.0, 1422.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1046.0, 1422.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1234.0, 1422.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 1422.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 1234.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 1046.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 858.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1422.0, 670.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1234.0, 670.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1046.0, 670.0) andDiameter:185.0]];
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(858.0, 670.0) andDiameter:185.0]];
    
    [pokeBoard.squares addObject:[SWBoardSquare squareWithCenterPoint:CGPointMake(1050.0, 1050.0) andDiameter:500.0]];
*/


    SWMatch *match = [SWMatch matchWithBoard:pokeBoard];
    [match.players addObject:[SWPlayer playerWithName:@"Sam"]];
    [match.players addObject:[SWPlayer playerWithName:@"Bill"]];
    [match.players addObject:[SWPlayer playerWithName:@"Dave"]];

    [self loadMatch:match];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self waitForRollWithNextAction:^{
        [self autoTurns];
    }];
    //[NSTimer scheduledTimerWithTimeInterval:3.25 target:self selector:@selector(goToRandomSquare:) userInfo:nil repeats:TRUE];

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
        NSInteger newSquareIndex = player.currentSquareIndex + arc4random()%6+1;
        [self walkPlayer:player toSquareIndex:newSquareIndex withCompleted:^{
            NSLog(@"Done Walking.");
            [self zoomInOnSquareIndex:newSquareIndex fadePlayersAndThenZoomOutWithCompleted:^{
                NSLog(@"Done Zooming.");
                [self waitForRollWithNextAction:^{
                    [self autoTurns];
                }];
                
            }];
        }];
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


- (void)loadMatch:(SWMatch *)match
{
    self.match = match;
    self.board = match.board;
    self.boardImageView.image = self.board.boardImage;
    CGSize boardSize = self.board.boardImage.size;
    self.containerView.frame = [self boardRectForScale:[self boardFitZoomScale] centeredOnCoordinate:CGPointMake(floor(boardSize.width/2), floor(boardSize.height/2))];
    
    for (SWPlayer *player in match.players) {
        player.token = [[UIView alloc] initWithFrame:CGRectMake(0,0,30.0,30.0)];
        if ([match.players indexOfObject:player] == 0) player.token.backgroundColor = [UIColor greenColor];
        else if ([match.players indexOfObject:player] == 1) player.token.backgroundColor = [UIColor blueColor];
        else player.token.backgroundColor = [UIColor redColor];
        
        player.token.layer.cornerRadius = 15;
        player.token.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        player.token.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        player.token.layer.shadowOpacity = 1.0;
        player.token.layer.shadowRadius = 1.0;
        [self.containerView addSubview:player.token];
        [self movePlayer:player toSquareIndex:0 withCompleted:nil];
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
    self.rollAction = block;
    NSInteger playerTurn = self.match.turnNumber % self.match.players.count;
    SWPlayer *player = [self.match.players objectAtIndex:playerTurn];
    NSLog(@"pre-send player: %@, Name: %@", player, player.name);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SWWaitingForRoll" object:player userInfo:nil];
}

- (void)rollDice
{
    if (self.rollAction){
        SWActionCallbackBlock action = self.rollAction;
        self.rollAction = nil;
        action();
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
    CGFloat tokenWidth = 30.0;
    return CGRectMake(convertedSquareCoord.x - floor(tokenWidth/2), convertedSquareCoord.y - floor(tokenWidth/2), tokenWidth, tokenWidth);
}

- (void)walkPlayer:(SWPlayer *)player toSquareIndex:(NSInteger)index withCompleted:(void (^)())block;
{
    if (player.currentSquareIndex + 1 >= self.board.squares.count) {
        if (block) block();
    }
    
    if (player.currentSquareIndex != index){
        [self movePlayer:player toSquareIndex:player.currentSquareIndex + 1 withCompleted:^{
            [self walkPlayer:player toSquareIndex:index withCompleted:block];
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
    
    //NSLog(@"READY? Scale: %f, Image Frame: %@", scale, NSStringFromCGRect(self.containerView.frame));
    
    CGFloat newX = (viewSize.width/2 - (boardSize.width * scale)) + convertedBoardOffset.x;
    CGFloat newY = ((viewSize.height/2 - (boardSize.height * scale))) + convertedBoardOffset.y;
    CGFloat newWidth = boardSize.width*scale;
    CGFloat newHeight = boardSize.height*scale;
    
    return CGRectMake(newX, newY, newWidth, newHeight);
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
