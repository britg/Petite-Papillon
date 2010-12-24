//
//  NewPhotoViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewPhotoViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UIImagePickerController *cameraViewController;
	
	IBOutlet UITableViewCell *anotherPhotoCell;
	
	IBOutlet UITableViewCell *butterflyCell;
	IBOutlet UITableViewCell *birdCell;
	IBOutlet UITableViewCell *rayrayCell;
	
	UIImage *editedImage;
	
}

@property (nonatomic, retain) UIImagePickerController *cameraViewController;
@property (nonatomic, retain) IBOutlet UITableViewCell *anotherPhotoCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *butterflyCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *birdCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *rayrayCell;

@property (nonatomic, retain) UIImage *editedImage;

- (void)showCamera;
- (void)createPetPicture;

@end
