//
//  SWGameControlViewController.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWGameControlViewController.h"

@interface SWGameControlViewController ()

@end

@implementation SWGameControlViewController

- (BOOL)canBecomeFirstResponder {
    return YES;
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitingForContinue:) name:@"SWWaitingForContinue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitingForRoll:) name:@"SWWaitingForRoll" object:nil];

    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"Controller will appear.");
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWLoadNewBoard" object:@{@"boardName":@"pokemon",@"players":self.players} userInfo:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motionEnded");
    if (event.subtype == UIEventSubtypeMotionShake && self.rollButton.enabled) {
        [self pressedRoll:self.rollButton];
    }
}


- (IBAction)pressedContinue:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWUserPressedContinue" object:nil];
    self.continueButton.enabled = FALSE;
    self.rollWithoutMovingButton.enabled = FALSE;
    self.continueButton.alpha = 0.3;
    self.rollWithoutMovingButton.alpha = 0.3;

}

- (IBAction)pressedRoll:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWUserPressedRoll" object:nil];
    self.rollButton.enabled = FALSE;
    self.rollWithoutMovingButton.enabled = FALSE;
    self.skipTurnButton.enabled = FALSE;
    self.backTurnButton.enabled = FALSE;
    
    self.rollButton.alpha = 0.3;
    self.rollWithoutMovingButton.alpha = 0.3;
    self.skipTurnButton.alpha = 0.3;
    self.backTurnButton.alpha = 0.3;

}

- (void)waitingForContinue:(NSNotification *)notification
{
    self.continueButton.enabled = TRUE;
    self.rollWithoutMovingButton.enabled = TRUE;
    self.continueButton.alpha = 1.0;
    self.rollWithoutMovingButton.alpha = 1.0;
    
    //NSDictionary *info = [notification userInfo];
    
}

- (void)waitingForRoll:(NSNotification *)notification
{
    self.rollButton.enabled = TRUE;
    self.rollWithoutMovingButton.enabled = TRUE;
    self.skipTurnButton.enabled = TRUE;
    self.backTurnButton.enabled = TRUE;
    
    self.rollButton.alpha = 1.0;
    self.rollWithoutMovingButton.alpha = 1.0;
    self.skipTurnButton.alpha = 1.0;
    self.backTurnButton.alpha = 1.0;
    
    
    NSLog(@"Not: %@ Obj: %@", notification, notification.object);

    if (notification.object){
        SWPlayer *player = notification.object;
        self.playerTurnLabel.text = [NSString stringWithFormat:@"%@'s Turn", player.name];
    }
}

- (IBAction)goBackTurn:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWGoBackATurn" object:nil];
}

- (IBAction)skipTurn:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWSkipTurn" object:nil];
}

- (IBAction)rollWithoutMoving:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"SWRollWithoutMoving" object:nil];
}

- (IBAction)quitGamePressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
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
