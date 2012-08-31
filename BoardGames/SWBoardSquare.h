//
//  SWBoardSquare.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWBoardSquare : NSObject

@property (nonatomic, strong) NSString *message;
@property CGRect bounds;
@property BOOL playerMustStopHere, switchToPikachu, extraTurn;
@property NSInteger teleportToSquareIndex;


+ (SWBoardSquare *)squareWithCenterPoint:(CGPoint)center andDiameter:(CGFloat)diameter;
+ (SWBoardSquare *)squareWithBounds:(CGRect)bounds;
- (CGPoint)centerCoordinate;

@end
