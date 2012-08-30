//
//  SWGameControlViewController.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTVBoardViewController.h"

@interface SWGameControlViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *continueButton, *rollButton;
@property (nonatomic, strong) IBOutlet UILabel *playerTurnLabel;

- (IBAction)pressedContinue:(id)sender;
- (IBAction)pressedRoll:(id)sender;

- (void)waitingForContinue:(NSNotification *)notification;
- (void)waitingForRoll:(NSNotification *)notification;

@end
