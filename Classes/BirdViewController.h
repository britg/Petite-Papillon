//
//  ButterflyViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "BirdsPhotoSource.h"
#import "AddBirdPhotoViewController.h"


@interface BirdViewController : UIViewController <TTThumbsViewControllerDelegate, UITabBarDelegate> {
	NSString *bird;
	NSInteger rowID;
	
	IBOutlet UITabBar *birdTabBar;
	IBOutlet UIWebView *webView;
	IBOutlet UIToolbar *webViewToolbar;
	
	BirdsPhotoSource *photoSet;
	TTThumbsViewController *thumbsView;
	TTPhotoViewController *photoView;
	IBOutlet UIView *thumbsViewContainer;
	
	IBOutlet UIBarButtonItem *addButton;
	AddBirdPhotoViewController *addPhotoView;
}

@property (nonatomic, retain) NSString *bird;
@property NSInteger rowID;
@property (nonatomic, retain) IBOutlet UITabBar *birdTabBar;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIToolbar *webViewToolbar;

@property (nonatomic, retain) BirdsPhotoSource *photoSet;
@property (nonatomic, retain) TTThumbsViewController *thumbsView;
@property (nonatomic, retain) TTPhotoViewController *photoView;
@property (nonatomic, retain) IBOutlet UIView *thumbsViewContainer;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) AddBirdPhotoViewController *addPhotoView;

- (void)loadWikipedia;
- (void)loadGoogle;
- (IBAction)websiteBack;
- (IBAction)websiteForward;
- (IBAction)websiteRefresh;
- (IBAction)addPhoto;

@end
