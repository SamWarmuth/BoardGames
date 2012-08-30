//
//  SWBoard.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWBoard.h"

@implementation SWBoard

+ (SWBoard *)boardWithImage:(UIImage *)image
{
    SWBoard *newBoard = [SWBoard new];
    newBoard.boardImage = image;
    newBoard.squares = [NSMutableArray new];
    return newBoard;
}

+ (SWBoard *)boardWithPlistNamed:(NSString *)name
{

	NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *boardInfo = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"board: %@", boardInfo);
    
    SWBoard *board = [SWBoard new];
    board.boardImage = [UIImage imageNamed:[boardInfo objectForKey:@"imagePath"]];
    board.squares = [NSMutableArray new];
    
    NSInteger squareDiameter = [[boardInfo objectForKey:@"squareDiameter"] integerValue];
    for (NSString *boardCenterString in (NSArray *)[boardInfo objectForKey:@"squareCenters"]){
        CGPoint boardCenter = CGPointFromString(boardCenterString);
        [board.squares addObject:[SWBoardSquare squareWithCenterPoint:boardCenter andDiameter:(float)squareDiameter]];
    }
    
    return board;
}

@end
