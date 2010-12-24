//
//  CureViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CureViewController : UIViewController {
	IBOutlet UIImageView *image;
	NSInteger selectedMood;
	
}

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property NSInteger selectedMood;

@end
