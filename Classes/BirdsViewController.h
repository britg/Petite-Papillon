//
//  ButterfliesViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BirdViewController.h"


@interface BirdsViewController : UITableViewController {
	NSMutableArray *birds;
	NSMutableArray *birdIndex;
	NSMutableArray *birdSearchResults;
	
	IBOutlet UITableViewCell *birdCell;
	
	IBOutlet UISearchBar *searchBar;
	BOOL isSearching;
	
	BirdViewController *birdView;
	
	
}

@property (nonatomic, retain) NSMutableArray *birds;
@property (nonatomic, assign) IBOutlet UITableViewCell *birdCell;
@property (nonatomic, retain) BirdViewController *birdView;


- (void)getBirdsFromDB;

@end
