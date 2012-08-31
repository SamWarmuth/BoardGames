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
    //NSLog(@"board: %@", boardInfo);
    
    SWBoard *board = [SWBoard new];
    board.boardImage = [UIImage imageNamed:[boardInfo objectForKey:@"imagePath"]];
    board.squares = [NSMutableArray new];
    
    NSInteger squareDiameter = [[boardInfo objectForKey:@"squareDiameter"] integerValue];
    for (NSDictionary *squareDict in (NSArray *)[boardInfo objectForKey:@"squares"]){
        CGPoint squareCenter = CGPointFromString([squareDict objectForKey:@"center"]);
        SWBoardSquare *square = [SWBoardSquare squareWithCenterPoint:squareCenter andDiameter:(float)squareDiameter];
        square.playerMustStopHere = [[squareDict objectForKey:@"playerMustStop"] boolValue];
        
        if ([squareDict objectForKey:@"teleportToIndex"]) square.teleportToSquareIndex = [[squareDict objectForKey:@"teleportToIndex"] intValue];
        else square.teleportToSquareIndex = -1;
        
        if ([squareDict objectForKey:@"switchToPikachu"]) square.switchToPikachu = [[squareDict objectForKey:@"switchToPikachu"] boolValue];
        else square.switchToPikachu = FALSE;
        
        
        
        [board.squares addObject:square];
    }
    
    return board;
}

@end
