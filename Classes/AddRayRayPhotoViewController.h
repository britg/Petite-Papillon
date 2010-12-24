//
//  AddRayRayPhotoViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddRayRayPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UIImagePickerController *pickerViewController;
	UIImage *editedImage;
}

@property (nonatomic, retain) UIImagePickerController *pickerViewController;
@property (nonatomic, retain) UIImage *editedImage;

- (void)showPicker;

@end
