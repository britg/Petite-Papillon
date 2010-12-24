//
//  MoodsViewController.h
//  papillon
//
//  Created by Brit Gardner on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CureViewController.h"

@interface MoodsViewController : UITableViewController {
	IBOutlet UITableViewCell *sadCell;
	IBOutlet UITableViewCell *tiredCell;
	IBOutlet UITableViewCell *frustratedCell;
	IBOutlet UITableViewCell *embarassedCell;
	IBOutlet UITableViewCell *stressedCell;
	IBOutlet UITableViewCell *sassyCell;
	CureViewController *cureView;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *sadCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *tiredCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *frustratedCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *embarassedCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *stressedCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *sassyCell;
@property (nonatomic, retain) IBOutlet CureViewController *cureView;

@end
