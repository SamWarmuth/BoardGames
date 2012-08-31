//
//  SWPlayer.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/29/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWPlayer.h"

@implementation SWPlayer

+ (SWPlayer *)playerWithName:(NSString *)name pokemonType:(SWPokemonType)type andColorIndex:(NSInteger)colorIndex
{
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor orangeColor], [UIColor blackColor]];
    UIColor *color = [colors objectAtIndex:(NSInteger)colorIndex];
    
    SWPlayer *player = [self playerWithName:name pokemonType:type andColor:color];
    player.tokenColorIndex = colorIndex;
    
    return player;
}

+ (SWPlayer *)playerWithName:(NSString *)name pokemonType:(SWPokemonType)type andColor:(UIColor *)color
{
    SWPlayer *player = [SWPlayer new];
    player.name = name;
    player.currentSquareIndex = 0;
    player.pokemonType = type;
    player.tokenColor = color;
    [player createToken];
    return player;
}

- (void)createToken
{
    [self setTokenWithImageNamed:[self pokemonImageName] andColor:self.tokenColor];
}

- (void)setTokenWithImageNamed:(NSString *)name andColor:(UIColor *)color
{
    self.token = nil;
    UIImageView *tokenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
    tokenImage.image = [UIImage imageNamed:name];
    tokenImage.backgroundColor = color;
    CALayer *layer = tokenImage.layer;
    layer.cornerRadius = 28.0;
    
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2.0;
    
    layer.shadowOffset = CGSizeMake(0.0, 2.0);
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 1.0;
    layer.shadowRadius = 2.0;

    self.token = tokenImage;
}

- (void)setTokenPokemon:(SWPokemonType)pokemon
{
    self.pokemonType = pokemon;
    self.token.image = [UIImage imageNamed:[self pokemonImageName]];
}

- (NSString *)pokemonImageName
{
    switch (self.pokemonType) {
        case SWPokemonBulbasaur:
            return @"bulbasaur";
        case SWPokemonCharmander:
            return @"charmander";
        case SWPokemonSquirtle:
            return @"squirtle";
        case SWPokemonPikachu:
            return @"pikachu";
        default:
            break;
    }
}

- (void)setTokenColorWithIndex:(SWTokenColor)index
{
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor orangeColor], [UIColor blackColor]];
    self.tokenColor = [colors objectAtIndex:(NSInteger)index];
    self.tokenColorIndex = index;
    [self createToken];
}

@end
