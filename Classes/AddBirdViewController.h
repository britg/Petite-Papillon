//
//  AddBirdViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddBirdViewController : UITableViewController {

	IBOutlet UITableViewCell *birdNameCell;
	IBOutlet UITextField *birdName;
	IBOutlet UIBarButtonItem *submitButton;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *birdNameCell;
@property (nonatomic, retain) IBOutlet UITextField *birdName;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *submitButton;

- (IBAction)submitAction;

@end
