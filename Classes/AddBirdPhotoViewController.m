//
//  AddRayRayPhotoViewController.m
//  papillon
//
//  Created by Brit Gardner on 12/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddBirdPhotoViewController.h"


@implementation AddBirdPhotoViewController

@synthesize pickerViewController;
@synthesize editedImage;
@synthesize rowID;


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self showPicker];
}


-(void) showPicker {
	DebugLog(@"Showing picker for Birds");
	
	if (!self.pickerViewController) {
		DebugLog(@"picker doesn't exist, so we're initializing...");
		self.pickerViewController = [[UIImagePickerController alloc] init];
	}
	
	
	self.pickerViewController.delegate = self;
	
	[self.pickerViewController setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]];
	self.pickerViewController.allowsEditing = YES;
	
	[self presentModalViewController:self.pickerViewController animated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	DebugLog(@"camera cancelled!");
	[picker dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	DebugLog(@"photo was picked from picker!");	
	[picker dismissModalViewControllerAnimated:YES];
	
	DebugLog(@"image info is %@", info);
	self.editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
	
	DebugLog(@"Writing image to local app directory");
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathToDocuments=[paths objectAtIndex:0];
	NSDate *now = [NSDate date];
	
	// determine if that bird has a directory
	NSString *pathToBird = [pathToDocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"birds/%i", self.rowID]];
	NSString *pathToBirdThumbs = [pathToDocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"bird_thumbs/%i", self.rowID]];
	BOOL isDir = YES;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:pathToBird isDirectory:&isDir]) {
		[fileManager createDirectoryAtPath:pathToBird withIntermediateDirectories:NO attributes:nil error:nil];
	}
	if (![fileManager fileExistsAtPath:pathToBirdThumbs isDirectory:&isDir]) {
		[fileManager createDirectoryAtPath:pathToBirdThumbs withIntermediateDirectories:NO attributes:nil error:nil];
	}
	
	NSString *pathComponent = [NSString stringWithFormat:@"birds/%i/%@.png", self.rowID, [now description]]; 
	NSString *pathToImage = [pathToDocuments stringByAppendingPathComponent:pathComponent];
	
	DebugLog(@"path to new image is %@", pathToImage);
	
	BOOL successfulWrite = [UIImagePNGRepresentation(self.editedImage) writeToFile:pathToImage atomically:YES];
	DebugLog(@"was write successful? %@", (successfulWrite ? @"YES" : @"NO"));
	
	// Create thumb image
	NSString *fullPathToThumbImage = [pathToDocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"bird_thumbs/%i/%@.png", self.rowID, [now description]]];
	
	DebugLog(@"path to new thumb image is %@", fullPathToThumbImage);
	UIImage *thumbnail;
	
	UIImageView *mainImageView = [[UIImageView alloc] initWithImage:self.editedImage];
	BOOL widthGreaterThanHeight = (self.editedImage.size.width > self.editedImage.size.height);
	float sideFull = (widthGreaterThanHeight) ? self.editedImage.size.height : self.editedImage.size.width;
	CGRect clippedRect = CGRectMake(0, 0, sideFull, sideFull);
	
	//creating a square context the size of the final image which we will then
	// manipulate and transform before drawing in the original image
	UIGraphicsBeginImageContext(CGSizeMake(75, 75));
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextClipToRect( currentContext, clippedRect);
	CGFloat scaleFactor = 75/sideFull;
	
	if (widthGreaterThanHeight) {
		//a landscape image – make context shift the original image to the left when drawn into the context
		CGContextTranslateCTM(currentContext, -((self.editedImage.size.width - sideFull) / 2) * scaleFactor, 0);
	}
	else {
		//a portfolio image – make context shift the original image upwards when drawn into the context
		CGContextTranslateCTM(currentContext, 0, -((self.editedImage.size.height - sideFull) / 2) * scaleFactor);
	}
	
	//this will automatically scale any CGImage down/up to the required thumbnail side (length) when the CGImage gets drawn into the context on the next line of code
	CGContextScaleCTM(currentContext, scaleFactor, scaleFactor);
	[mainImageView.layer renderInContext:currentContext];
	thumbnail = UIGraphicsGetImageFromCurrentImageContext();
	//DebugLog(@"bird thumbnail is %@", thumbnail);
	UIGraphicsEndImageContext();
	NSData *imageData = UIImagePNGRepresentation(thumbnail);
	//DebugLog(@"bird thumb image data is %@", imageData);
	BOOL successfulThumbWrite = [imageData writeToFile:fullPathToThumbImage atomically:YES];
	DebugLog(@"was thumb write successful? %@", (successfulThumbWrite ? @"YES" : @"NO"));
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
