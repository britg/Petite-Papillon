//
//  RaisedCenterTabBarController.m
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RaisedCenterTabBarController.h"

@implementation RaisedCenterTabBarController

@synthesize centerButton;

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image
{
	UIViewController* viewController = [[[UIViewController alloc] init] autorelease];
	viewController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:title image:image tag:0] autorelease];
	return viewController;
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
	self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.centerButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
	[self.centerButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[self.centerButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
	
	CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
	if (heightDifference < 0)
		self.centerButton.center = self.tabBar.center;
	else
	{
		CGPoint center = self.tabBar.center;
		center.y = center.y - heightDifference/2.0;
		self.centerButton.center = center;
	}
	
	[self.centerButton addTarget:self action:@selector(startNewPhoto) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:self.centerButton];
}

- (void)startNewPhoto {
	self.selectedIndex = 2;
}
@end
