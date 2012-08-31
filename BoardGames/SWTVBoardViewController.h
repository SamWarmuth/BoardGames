//
//  SWTVBoardViewController.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWMatch.h"
#import "SVProgressHUD.h"
typedef void (^SWActionCallbackBlock)(void);


#define SWPlayerTokenOffset 10000

@interface SWTVBoardViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *containerView, *sideboard;
@property (nonatomic, strong) IBOutlet UIImageView *boardImageView, *dieImageView;
@property (nonatomic, strong) NSMutableArray *playerLabels;
@property (nonatomic, strong) SWMatch *match;
@property (nonatomic, strong) SWBoard *board;
@property (nonatomic, strong) NSMutableArray *playerTokens;
@property NSInteger currentSquareIndex, currentDieValue;
@property (nonatomic, strong) UIView *messageOverlay;

@property (nonatomic, strong) SWActionCallbackBlock continueAction, rollAction, rollAnimationCompleteAction;

@property (nonatomic, strong) IBOutlet UIButton *continueButton;
- (IBAction)continuePressed:(id)sender;


- (void)updateSideboard;

- (void)zoomToScale:(CGFloat)scale centeredOnBoardCoordinate:(CGPoint)boardCoord withCompleted:(void (^)())block;
- (void)loadBoard:(NSNotification *)notification;

- (void)animateDieRollWithCompleted:(void (^)())block;

- (void)waitForContinueWithNextAction:(void (^)())block;
- (void)continueGameplay;

- (void)waitForRollWithNextAction:(void (^)())block;
- (void)rollDice;

@end
