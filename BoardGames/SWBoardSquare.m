//
//  SWBoardSquare.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWBoardSquare.h"

@implementation SWBoardSquare

+ (SWBoardSquare *)squareWithCenterPoint:(CGPoint)center andDiameter:(CGFloat)diameter
{
    SWBoardSquare *newSquare = [SWBoardSquare new];
    newSquare.bounds = CGRectMake(center.x - (diameter / 2), center.y - (diameter / 2), diameter, diameter);
    return newSquare;
}

+ (SWBoardSquare *)squareWithBounds:(CGRect)bounds
{
    SWBoardSquare *newSquare = [SWBoardSquare new];
    newSquare.bounds = bounds;
    return newSquare;
}

- (CGPoint)centerCoordinate
{
    return CGPointMake(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2);
}

@end
