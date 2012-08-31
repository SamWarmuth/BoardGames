//
//  SWGameSetupViewController.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWGameSetupViewController.h"
#import "SWCreatePlayerCell.h"
#import "SWGameControlViewController.h"
#import "SWTVBoardViewController.h"

@interface SWGameSetupViewController ()

@end

@implementation SWGameSetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeShowKeyboard) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(noticeHideKeyboard) name:UIKeyboardWillHideNotification object:nil];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.players = [NSMutableArray new];
	[self.players addObject:[SWPlayer playerWithName:@"Sam" pokemonType:SWPokemonBulbasaur andColorIndex:SWTokenOrange]];
    [self.players addObject:[SWPlayer playerWithName:@"Dave" pokemonType:SWPokemonCharmander andColorIndex:SWTokenGreen]];
	[self.players addObject:[SWPlayer playerWithName:@"Bill" pokemonType:SWPokemonSquirtle andColorIndex:SWTokenRed]];
	[self.players addObject:[SWPlayer playerWithName:@"Nick" pokemonType:SWPokemonSquirtle andColorIndex:SWTokenBlue]];
}

- (void)noticeShowKeyboard
{
    NSLog(@"keyboard shown.");
    self.tv.frame = CGRectMake(0, 0, 320, 200);
}

- (void)noticeHideKeyboard
{
    self.tv.frame = CGRectMake(0, 0, 320, 372);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SWCreatePlayerCell";
    SWCreatePlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SWCreatePlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.deletePlayerButton addTarget:self action:@selector(deletePlayerPressed:) forControlEvents:UIControlEventTouchUpInside];
    cell.deletePlayerButton.tag = indexPath.row;

    cell.player = [self.players objectAtIndex:indexPath.row];
    [cell updateUI];
    
    return cell;
}

- (void)deletePlayerPressed:(UIButton *)sender
{
    if (self.players.count == 1) return;
    NSLog(@"delete player at index: %d", sender.tag);
    [self.players removeObjectAtIndex:sender.tag];
    [self.tv reloadData];
}

- (IBAction)addPlayerPressed:(id)sender
{
	[self.players addObject:[SWPlayer playerWithName:@"" pokemonType:SWPokemonBulbasaur andColor:[UIColor redColor]]];
    [self.tv reloadData];
}

- (IBAction)startGamePressed:(id)sender
{
    BOOL error = FALSE;
    
    for (SWPlayer *player in self.players){
        if (player.name.length == 0) error = TRUE;
    }
    
    if (error){
        [SVProgressHUD show];
        [SVProgressHUD dismissWithError:@"All players need to have a name."];
    } else {
        [self performSegueWithIdentifier:@"SWSetupToGame" sender:self];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SWSetupToGame"]){
        if ([self isiPad]){
            NSString *boardPlistName = @"pokemon";
            SWBoard *pokeBoard = [SWBoard boardWithPlistNamed:boardPlistName];
            SWMatch *match = [SWMatch matchWithBoard:pokeBoard];
            match.players = self.players;
            
            SWTVBoardViewController *destinationView = segue.destinationViewController;
            destinationView.match = match;
        } else {
            SWGameControlViewController *destinationView = segue.destinationViewController;
            destinationView.players = self.players;
        }

    }
}



- (BOOL)isiPad {
    return (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:TRUE];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
