//
//  RayRaysViewController.m
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RayRaysViewController.h"
#import "RayRaysPhotoSource.h"


@implementation RayRaysViewController

@synthesize addButton;
@synthesize picker;
@synthesize photoSet;

#pragma mark -
#pragma mark View lifecycle


- (void) viewDidLoad {
	DebugLog(@"Ray Ray photo view is loading!!");
	self.navigationBarTintColor = UIColorFromRGB(0x5B36A0);
	self.navigationItem.title = @"RayRays";
	self.delegate = self;
	[self createAddButton];
}

- (void)createAddButton {
	DebugLog(@"Creating add button");
	self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhoto)];
	self.navigationItem.rightBarButtonItem = self.addButton;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self invalidateModel];
	[self refreshSources];
	[self updateView];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	//[self refreshSources];
	//[self updateView];
	SHOW_CENTER_BUTTON;
}

- (void)refreshSources {
	self.photoSource = nil;
	self.photoSet = nil;
	self.photoSet = [[RayRaysPhotoSource alloc] init];
    self.photoSource = self.photoSet;
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Actions

- (void)addPhoto{
	DebugLog(@"Add photo button pressed!");
	if (!self.picker) {
		self.picker = [[AddRayRayPhotoViewController alloc] initWithNibName:@"AddRayRayPhotoViewController" bundle:nil];
	}
	[self.navigationController pushViewController:self.picker
										 animated:YES];
}

- (void)thumbsViewController:(TTThumbsViewController*)controller 
			  didSelectPhoto:(id<TTPhoto>)photo {
	DebugLog(@"thumb touched");
	HIDE_CENTER_BUTTON;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    DebugLog(@"Ray Rays photo view did receive memory warning!");
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	DebugLog(@"Ray Rays photo view did unload!");
	[super viewDidUnload];
	self.photoSet = nil;
	self.picker = nil;
	self.photoSource = nil;
}

- (void) dealloc {
    [super dealloc];
	self.photoSet = nil;
	self.photoSource = nil;
	self.picker = nil;
}


@end

