//
//  SWPlayer.h
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SWPokemonBulbasaur,
    SWPokemonCharmander,
    SWPokemonSquirtle,
    SWPokemonPikachu
} SWPokemonType;

//NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor orangeColor], [UIColor blackColor]];
typedef enum {
    SWTokenRed,
    SWTokenGreen,
    SWTokenBlue,
    SWTokenOrange,
    SWTokenBlack
} SWTokenColor;

@interface SWPlayer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImageView *token;
@property (nonatomic, strong) UIColor *tokenColor;
@property SWPokemonType pokemonType;
@property NSInteger currentSquareIndex;
@property SWTokenColor tokenColorIndex;

+ (SWPlayer *)playerWithName:(NSString *)name pokemonType:(SWPokemonType)type andColorIndex:(NSInteger)colorIndex;
+ (SWPlayer *)playerWithName:(NSString *)name pokemonType:(SWPokemonType)type andColor:(UIColor *)color;
- (void)createToken;
- (void)setTokenWithImageNamed:(NSString *)name andColor:(UIColor *)color;
- (void)setTokenColorWithIndex:(SWTokenColor)index;
- (void)setTokenPokemon:(SWPokemonType)pokemon;

@end
