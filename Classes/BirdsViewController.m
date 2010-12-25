//
//  ButterfliesViewController.m
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BirdsViewController.h"
#import "FMDatabase.h"


@implementation BirdsViewController

@synthesize birds;
@synthesize birdCell;
@synthesize birdView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.navigationItem.title = @"Oiseaux";
	
	[self getBirdsFromDB];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	SHOW_CENTER_BUTTON;
}

/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark -
#pragma mark Data source

- (void)getBirdsFromDB {
	FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
	[db setLogsErrors:YES];
	[db open];
	NSString *query = @"SELECT ROWID, * FROM birds ORDER BY name;";
	
	FMResultSet *result = [db executeQuery:query];
	
	self.birds = [[[NSMutableArray alloc] init] autorelease];
	birdIndex = [[NSMutableArray alloc] init];
	
	
	[birdIndex addObject:UITableViewIndexSearch];
	while ([result next]) {
		NSString *birdName = [result stringForColumn:@"name"];
		[self.birds addObject:birdName];
		char alpha = [birdName characterAtIndex:0];
		NSString *uniChar = [[NSString stringWithFormat:@"%C", alpha] capitalizedString];
		
		if (![birdIndex containsObject:uniChar]) {
			[birdIndex addObject:uniChar];
		}
	}
	[result close];
	[db close];
	birdSearchResults = [[NSMutableArray alloc] init];
	[birdSearchResults addObjectsFromArray:self.birds];
}



#pragma mark -
#pragma mark Search delegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBarRef {
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	searchBar.showsCancelButton = YES;
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBarRef {
	isSearching = NO;
	[searchBar resignFirstResponder];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	searchBar.showsCancelButton = NO;
	searchBar.text = @"";
	
	[birdSearchResults removeAllObjects];
	[birdSearchResults addObjectsFromArray:self.birds];
	[self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBarRef {
	[searchBar resignFirstResponder];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	searchBar.showsCancelButton = NO;
}

- (void) searchBar:(UISearchBar *)searchBarRef textDidChange:(NSString *)searchText {
	if ([searchText length] > 0) {
		isSearching = YES;
		[birdSearchResults removeAllObjects];
		NSString *searchText = searchBar.text;
		DebugLog(@"search test is %@", searchText);
		
		for (NSString *bird in self.birds) {
			NSRange titleResultsRange = [bird rangeOfString:searchText options:NSCaseInsensitiveSearch];
			
			if (titleResultsRange.length > 0) {
				[birdSearchResults addObject:bird];
			}
		}
	} else {
		isSearching = NO;
		[birdSearchResults removeAllObjects];
		[birdSearchResults addObjectsFromArray:self.birds];
	}
	
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if (isSearching) {
		return nil;
	}
	
	return birdIndex;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if (isSearching) {
		return 1;
	}
    
	return [birdIndex count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return nil;
	}
	return [birdIndex objectAtIndex:section];
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title
                atIndex:(NSInteger)index {
    if (index == 0) {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    return index;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (isSearching) {
		return [birdSearchResults count];
	}
    
	NSString *alpha = [birdIndex objectAtIndex:section];
	NSPredicate *predicate = 
	[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", alpha];
    NSArray *matches = [self.birds filteredArrayUsingPredicate:predicate];
	
	return [matches count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BirdCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"BirdCell" owner:self options:nil];
		cell = birdCell;
		self.birdCell = nil;
    }
	
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:0];
    
    if (isSearching) {
		// Configure the cell...
		NSString *birdForCell = [birdSearchResults objectAtIndex:indexPath.row];
		label.text = birdForCell;
	} else {
		NSString *alpha = [birdIndex objectAtIndex:indexPath.section];
		NSPredicate *predicate = 
		[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", alpha];
		NSArray *matches = [self.birds filteredArrayUsingPredicate:predicate];
		label.text = [matches objectAtIndex:indexPath.row];
	}
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
	UILabel *label = (UILabel *)[selectedCell viewWithTag:0];
	
	DebugLog(@"The selected bird was %@", label);
	
	self.birdView = nil;
	if (!self.birdView) {
		self.birdView = [[BirdViewController alloc] initWithNibName:@"BirdViewController" bundle:nil];
		
	}
	
	self.birdView.bird = label.text;
	self.birdView.hidesBottomBarWhenPushed = YES;
	
	// Set bird rowid
	FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
	[db setLogsErrors:YES];
	[db open];
	NSString *query = @"SELECT ROWID FROM birds WHERE name = ? limit 1;";
	
	FMResultSet *result = [db executeQuery:query, label.text];
	
	while ([result next]) {
		self.birdView.rowID = [[result stringForColumn:@"ROWID"] intValue];
	}
	[result close];
	[db close];
	
	HIDE_CENTER_BUTTON;
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.navigationController pushViewController:self.birdView animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

