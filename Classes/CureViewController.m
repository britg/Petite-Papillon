//
//  CureViewController.m
//  papillon
//
//  Created by Brit Gardner on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CureViewController.h"


@implementation CureViewController

@synthesize image;
@synthesize selectedMood;


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (self.selectedMood == 0) {
		self.image.image = [UIImage imageNamed:@"sad.jpg"];
	} else if (self.selectedMood == 1) {
		self.image.image = [UIImage imageNamed:@"tired.jpg"];
	} else if (self.selectedMood == 2) {
		self.image.image = [UIImage imageNamed:@"Default.png"];
	} else if (self.selectedMood == 3) {
		self.image.image = [UIImage imageNamed:@"happy.jpg"];
	} else if (self.selectedMood == 4) {
		self.image.image = [UIImage imageNamed:@"stressed.jpg"];
	} else if (self.selectedMood == 5) {
		self.image.image = [UIImage imageNamed:@"sassy.jpg"];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
