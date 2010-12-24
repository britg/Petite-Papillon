//
//  RayRaysViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "AddRayRayPhotoViewController.h"
#import "RayRaysPhotoSource.h"


@interface RayRaysViewController : TTThumbsViewController <TTThumbsViewControllerDelegate> {
	UIBarButtonItem *addButton;
	AddRayRayPhotoViewController *picker;
	RayRaysPhotoSource *photoSet;
}

@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) AddRayRayPhotoViewController *picker;
@property (nonatomic, retain) RayRaysPhotoSource *photoSet;

- (void)createAddButton;
- (void)refreshSources;
- (void)addPhoto;

@end
