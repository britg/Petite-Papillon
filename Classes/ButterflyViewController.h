//
//  ButterflyViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "ButterfliesPhotoSource.h"
#import "AddButterflyPhotoViewController.h"


@interface ButterflyViewController : UIViewController <TTThumbsViewControllerDelegate, UITabBarDelegate> {
	NSString *butterfly;
	NSInteger rowID;
	
	IBOutlet UITabBar *butterflyTabBar;
	IBOutlet UIWebView *webView;
	IBOutlet UIToolbar *webViewToolbar;
	
	ButterfliesPhotoSource *photoSet;
	TTThumbsViewController *thumbsView;
	TTPhotoViewController *photoView;
	IBOutlet UIView *thumbsViewContainer;
	
	IBOutlet UIBarButtonItem *addButton;
	AddButterflyPhotoViewController *addPhotoView;
}

@property (nonatomic, retain) NSString *butterfly;
@property NSInteger rowID;
@property (nonatomic, retain) IBOutlet UITabBar *butterflyTabBar;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIToolbar *webViewToolbar;

@property (nonatomic, retain) ButterfliesPhotoSource *photoSet;
@property (nonatomic, retain) TTThumbsViewController *thumbsView;
@property (nonatomic, retain) TTPhotoViewController *photoView;
@property (nonatomic, retain) IBOutlet UIView *thumbsViewContainer;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) AddButterflyPhotoViewController *addPhotoView;

- (void)loadWikipedia;
- (void)loadGoogle;
- (IBAction)websiteBack;
- (IBAction)websiteForward;
- (IBAction)websiteRefresh;
- (IBAction)addPhoto;

@end
