//
//  AddBirdViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddButterflyViewController : UITableViewController {
	
	IBOutlet UITableViewCell *butterflyNameCell;
	IBOutlet UITextField *butterflyName;
	IBOutlet UIBarButtonItem *submitButton;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *butterflyNameCell;
@property (nonatomic, retain) IBOutlet UITextField *butterflyName;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *submitButton;

- (IBAction)submitAction;

@end
