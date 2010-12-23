//
//  ButterflyViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ButterflyViewController : UIViewController <UITabBarDelegate> {
	NSString *butterfly;
	IBOutlet UITabBar *butterflyTabBar;
	IBOutlet UIWebView *webView;
	IBOutlet UIToolbar *webViewToolbar;
}

@property (nonatomic, retain) NSString *butterfly;
@property (nonatomic, retain) IBOutlet UITabBar *butterflyTabBar;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIToolbar *webViewToolbar;

- (void)loadWikipedia;
- (void)loadGoogle;
- (IBAction)websiteBack;
- (IBAction)websiteForward;
- (IBAction)websiteRefresh;

@end
