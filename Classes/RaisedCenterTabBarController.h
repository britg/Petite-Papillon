//
//  BaseViewController.h
//  RaisedCenterTabBar
//
//  Created by Peter Boctor on 12/15/10.
//  Copyright 2010 Boctor Design. All rights reserved.
//

#import "NewPhotoViewController.h"

@interface RaisedCenterTabBarController : UITabBarController
{
	UIImagePickerController *cameraViewController;
	NewPhotoViewController *photoHandler;
}

@property (nonatomic, retain) UIImagePickerController *cameraViewController;
@property (nonatomic, retain) NewPhotoViewController *photoHandler;

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*)title image:(UIImage*)image;

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;

@end