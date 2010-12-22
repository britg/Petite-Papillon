//
//  ButterfliesViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ButterfliesViewController : UITableViewController {
	NSMutableArray *butterflies;
	NSMutableArray *butterflyIndex;
	NSMutableArray *butterflySearchResults;
	
	IBOutlet UITableViewCell *butterflyCell;

	IBOutlet UISearchBar *searchBar;
	BOOL isSearching;
}

@property (nonatomic, retain) NSMutableArray *butterflies;
@property (nonatomic, assign) IBOutlet UITableViewCell *butterflyCell;

- (void)getButterfliesFromDB;

@end
