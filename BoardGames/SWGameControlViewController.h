//
//  SWGameControlViewController.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTVBoardViewController.h"

@interface SWGameControlViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *continueButton, *rollButton, *rollWithoutMovingButton, *backTurnButton, *skipTurnButton;
@property (nonatomic, strong) IBOutlet UILabel *playerTurnLabel;
@property (nonatomic, strong) NSMutableArray *players;

- (IBAction)pressedContinue:(id)sender;
- (IBAction)pressedRoll:(id)sender;

- (void)waitingForContinue:(NSNotification *)notification;
- (void)waitingForRoll:(NSNotification *)notification;

- (IBAction)goBackTurn:(id)sender;
- (IBAction)skipTurn:(id)sender;
- (IBAction)rollWithoutMoving:(id)sender;
- (IBAction)quitGamePressed:(id)sender;


@end
