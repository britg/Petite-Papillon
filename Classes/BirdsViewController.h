//
//  ButterfliesViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BirdViewController.h"
#import "AddBirdViewController.h"


@interface BirdsViewController : UITableViewController {
	NSMutableArray *birds;
	NSMutableArray *birdIndex;
	NSMutableArray *birdSearchResults;
	
	IBOutlet UITableViewCell *birdCell;
	
	IBOutlet UISearchBar *searchBar;
	BOOL isSearching;
	
	BirdViewController *birdView;
	
	IBOutlet UIBarButtonItem *addButton;
	
	AddBirdViewController *addBirdView;
}

@property (nonatomic, retain) NSMutableArray *birds;
@property (nonatomic, assign) IBOutlet UITableViewCell *birdCell;
@property (nonatomic, retain) BirdViewController *birdView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;

@property (nonatomic, retain) AddBirdViewController *addBirdView;


- (void)getBirdsFromDB;
- (IBAction)addBird;

@end
