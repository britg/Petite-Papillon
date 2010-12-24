//
//  NewPhotoViewController.m
//  papillon
//
//  Created by Brit Gardner on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewPhotoViewController.h"
#import "RayRaysViewController.h"


@implementation NewPhotoViewController

@synthesize cameraViewController;
@synthesize anotherPhotoCell;
@synthesize butterflyCell;
@synthesize birdCell;
@synthesize rayrayCell;
@synthesize editedImage;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.title = @"What Next?";
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self showCamera];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"";
	}
	return @"Associate this photo";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0) {
		return 1;
	}
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.section == 0) {
		return anotherPhotoCell;
	}
    if (indexPath.row == 0) {
		return butterflyCell;
	} else if (indexPath.row == 1) {
		return birdCell;
	}
	
	return rayrayCell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.section == 0) {
		[self showCamera];
		return;
	}
	
	if (indexPath.row == 2) {
		self.tabBarController.selectedIndex = 3;
		[(RayRaysViewController *)[[[self.tabBarController viewControllers] objectAtIndex:3] topViewController] addPhoto];
	}
}

#pragma mark -
#pragma mark UIImagePicker Delegate


-(void) showCamera {
	DebugLog(@"Camera button selected...");
	if (!self.cameraViewController) {
		DebugLog(@"Camera view controller doesn't exist, so we're initializing...");
		self.cameraViewController = [[UIImagePickerController alloc] init];
	}
	
	
	self.cameraViewController.delegate = self;
	
	BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
	
	if (hasCamera) {
		self.cameraViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
	} else {
		self.cameraViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
	
	[self.cameraViewController setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]];
	self.cameraViewController.allowsEditing = NO;
	
	[self presentModalViewController:self.cameraViewController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	DebugLog(@"camera cancelled!");
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	DebugLog(@"camera successfully took picture!");	
	[picker dismissModalViewControllerAnimated:YES];
	
	DebugLog(@"image info is %@", info);
	self.editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	if (self.editedImage != nil) {
		DebugLog(@"Writing image to photos");
		UIImageWriteToSavedPhotosAlbum(self.editedImage, nil, nil, nil);
	}
}

/*
- (void)createPetPicture:(UIImage *)editedImage {
	DebugLog(@"Writing image to local app directory");
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathToDocuments=[paths objectAtIndex:0];
	NSString *pathToImage = [pathToDocuments stringByAppendingPathComponent:@"rayrays/123.png"];
	
	DebugLog(@"image data is %@", editedImage);
	BOOL successfulWrite = [UIImagePNGRepresentation(editedImage) writeToFile:pathToImage atomically:YES];
	DebugLog(@"path to image is %@", pathToImage);
	DebugLog(@"was write successful? %@", (successfulWrite ? @"YES" : @"NO"));
}
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

