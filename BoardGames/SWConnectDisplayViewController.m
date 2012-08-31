//
//  SWConnectDisplayViewController.m
//  BoardGames
//
//  Created by Samuel Warmuth on 8/30/12.
//  Copyright (c) 2012 Sam Warmuth. All rights reserved.
//

#import "SWConnectDisplayViewController.h"

@interface SWConnectDisplayViewController ()

@end

@implementation SWConnectDisplayViewController

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
    NSLog(@"?");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newDisplayConnected) name:@"SWDisplayConnected" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    SWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate externalDisplayConnected]){
        NSLog(@"yes.");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UITableViewController *gameChooserTableView = [storyboard instantiateViewControllerWithIdentifier:@"SWGameChooserTableView"];
        self.navigationController.viewControllers = @[gameChooserTableView];
    }
    NSLog(@"no");
}

- (void)newDisplayConnected
{
    NSLog(@"no.");

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UITableViewController *gameChooserTableView = [storyboard instantiateViewControllerWithIdentifier:@"SWGameChooserTableView"];
    self.navigationController.viewControllers = @[gameChooserTableView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
