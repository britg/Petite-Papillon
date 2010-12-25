//
//  ButterfliesViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ButterflyViewController.h"
#import "AddButterflyViewController.h"


@interface ButterfliesViewController : UITableViewController {
	NSMutableArray *butterflies;
	NSMutableArray *butterflyIndex;
	NSMutableArray *butterflySearchResults;
	
	IBOutlet UITableViewCell *butterflyCell;

	IBOutlet UISearchBar *searchBar;
	BOOL isSearching;
	
	ButterflyViewController *butterflyView;
	AddButterflyViewController *addButterflyView;
	
	IBOutlet UIBarButtonItem *addButton;
}

@property (nonatomic, retain) NSMutableArray *butterflies;
@property (nonatomic, assign) IBOutlet UITableViewCell *butterflyCell;
@property (nonatomic, retain) ButterflyViewController *butterflyView;
@property (nonatomic, retain) AddButterflyViewController *addButterflyView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;

- (void)getButterfliesFromDB;
- (IBAction)addButterfly;
- (void)reloadButterflies;

@end
