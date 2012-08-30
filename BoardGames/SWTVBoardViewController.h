//
//  SWTVBoardViewController.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWMatch.h"

typedef void (^SWActionCallbackBlock)(void);

#define SWPlayerTokenOffset 10000

@interface SWTVBoardViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIImageView *boardImageView;
@property (nonatomic, strong) SWMatch *match;
@property (nonatomic, strong) SWBoard *board;
@property (nonatomic, strong) NSMutableArray *playerTokens;
@property NSInteger currentSquareIndex;

@property (nonatomic, strong) SWActionCallbackBlock continueAction, rollAction;


- (void)zoomToScale:(CGFloat)scale centeredOnBoardCoordinate:(CGPoint)boardCoord withCompleted:(void (^)())block;

- (void)waitForContinueWithNextAction:(void (^)())block;
- (void)continueGameplay;

- (void)waitForRollWithNextAction:(void (^)())block;
- (void)rollDice;

@end
