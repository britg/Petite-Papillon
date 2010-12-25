//
//  ButterfliesViewController.m
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ButterfliesViewController.h"
#import "FMDatabase.h"


@implementation ButterfliesViewController

@synthesize butterflies;
@synthesize butterflyCell;
@synthesize butterflyView;
@synthesize addButterflyView;
@synthesize addButton;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Papillons";
	self.navigationItem.rightBarButtonItem = self.addButton;
	
}

- (void)reloadButterflies {
	[self getButterfliesFromDB];
	[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self reloadButterflies];
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

- (void)getButterfliesFromDB {
	FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
	[db setLogsErrors:YES];
	[db open];
	NSString *query = @"SELECT ROWID, * FROM butterflies ORDER BY name;";
	
	FMResultSet *result = [db executeQuery:query];
	
	self.butterflies = [[[NSMutableArray alloc] init] autorelease];
	butterflyIndex = [[NSMutableArray alloc] init];
	
	
	[butterflyIndex addObject:UITableViewIndexSearch];
	while ([result next]) {
		NSString *butterflyName = [result stringForColumn:@"name"];
		[self.butterflies addObject:butterflyName];
		char alpha = [butterflyName characterAtIndex:0];
		NSString *uniChar = [[NSString stringWithFormat:@"%C", alpha] capitalizedString];
		
		if (![butterflyIndex containsObject:uniChar]) {
			[butterflyIndex addObject:uniChar];
		}
	}
	[result close];
	[db close];
	butterflySearchResults = [[NSMutableArray alloc] init];
	[butterflySearchResults addObjectsFromArray:self.butterflies];
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
	
	[butterflySearchResults removeAllObjects];
	[butterflySearchResults addObjectsFromArray:self.butterflies];
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
		[butterflySearchResults removeAllObjects];
		NSString *searchText = searchBar.text;
		DebugLog(@"search test is %@", searchText);
		
		for (NSString *butterfly in self.butterflies) {
			NSRange titleResultsRange = [butterfly rangeOfString:searchText options:NSCaseInsensitiveSearch];
			
			if (titleResultsRange.length > 0) {
				[butterflySearchResults addObject:butterfly];
			}
		}
	} else {
		isSearching = NO;
		[butterflySearchResults removeAllObjects];
		[butterflySearchResults addObjectsFromArray:self.butterflies];
	}
	
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if (isSearching) {
		return nil;
	}
	
	return butterflyIndex;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if (isSearching) {
		return 1;
	}
    
	return [butterflyIndex count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return nil;
	}
	return [butterflyIndex objectAtIndex:section];
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
		return [butterflySearchResults count];
	}
    
	NSString *alpha = [butterflyIndex objectAtIndex:section];
	NSPredicate *predicate = 
	[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", alpha];
    NSArray *matches = [self.butterflies filteredArrayUsingPredicate:predicate];
	
	return [matches count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ButterflyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ButterflyCell" owner:self options:nil];
		cell = butterflyCell;
		self.butterflyCell = nil;
    }
	
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:0];
    
    if (isSearching) {
		// Configure the cell...
		NSString *butterflyForCell = [butterflySearchResults objectAtIndex:indexPath.row];
		label.text = butterflyForCell;
	} else {
		NSString *alpha = [butterflyIndex objectAtIndex:indexPath.section];
		NSPredicate *predicate = 
		[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", alpha];
		NSArray *matches = [self.butterflies filteredArrayUsingPredicate:predicate];
		label.text = [matches objectAtIndex:indexPath.row];
	}
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
	UILabel *label = (UILabel *)[selectedCell viewWithTag:0];
	
	DebugLog(@"The selected butterfly was %@", label);
	
	self.butterflyView = nil;
	if (!self.butterflyView) {
		self.butterflyView = [[ButterflyViewController alloc] initWithNibName:@"ButterflyViewController" bundle:nil];
	
	}
	
	self.butterflyView.butterfly = label.text;
	self.butterflyView.hidesBottomBarWhenPushed = YES;
	
	// Set butterfly rowid
	FMDatabase *db = [FMDatabase databaseWithPath:DB_PATH];
	[db setLogsErrors:YES];
	[db open];
	NSString *query = @"SELECT ROWID FROM butterflies WHERE name = ? limit 1;";
	
	FMResultSet *result = [db executeQuery:query, label.text];
	
	while ([result next]) {
		self.butterflyView.rowID = [[result stringForColumn:@"ROWID"] intValue];
	}
	[result close];
	[db close];

	HIDE_CENTER_BUTTON;
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.navigationController pushViewController:self.butterflyView animated:YES];
}

#pragma mark -
#pragma mark Actions

- (IBAction)addButterfly {
	DebugLog(@"Add butterfly action called");
	
	if (!self.addButterflyView) {
		self.addButterflyView = [[AddButterflyViewController alloc] initWithNibName:@"AddButterflyViewController" bundle:nil];
	}
	[self.navigationController pushViewController:self.addButterflyView animated:YES];	
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

