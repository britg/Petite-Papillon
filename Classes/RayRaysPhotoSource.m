//
//  RayRaysPhotoSource.m
//  papillon
//
//  Created by Brit Gardner on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RayRaysPhotoSource.h"
#import "Photo.h"


@implementation RayRaysPhotoSource
@synthesize title = _title;
@synthesize photos = _photos;

- (id) init {
	self = [super init];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathToDocuments=[paths objectAtIndex:0];
	
	NSError *error;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSString *pathToRayRays = [pathToDocuments stringByAppendingPathComponent:@"rayrays/"];
	NSArray *rayRayContents = [fileMgr contentsOfDirectoryAtPath:pathToRayRays error:&error];
	
	// Write out the contents of home directory to console
	DebugLog(@"rays rays directory: %@", rayRayContents);
	
	NSMutableArray *tempPhotos = [[[NSMutableArray alloc] init] autorelease];
	
	for (int i=0; i < rayRayContents.count; i++) {
		NSString *path = [NSString stringWithFormat:@"documents://rayrays/%@", [rayRayContents objectAtIndex:i]];
		NSString *thumbPath = [NSString stringWithFormat:@"documents://rayray_thumbs/%@", [rayRayContents objectAtIndex:i]];
		Photo *photo = [[[Photo alloc] initWithCaption:@"" 
											  urlLarge:path
											  urlSmall:thumbPath  
											  urlThumb:thumbPath
												  size:CGSizeMake(1024, 768)] autorelease];
		photo.photoSource = self;
		photo.index = i;
		[tempPhotos addObject:photo];
	}
	
	self.photos = tempPhotos;
	return self;
}

- (id) initWithTitle:(NSString *)title photos:(NSArray *)photos {
    if ((self = [super init])) {
        self.title = title;
        self.photos = photos;
        for(int i = 0; i < _photos.count; ++i) {
            Photo *photo = [_photos objectAtIndex:i];
            photo.photoSource = self;
            photo.index = i;
        }        
    }
    return self;
}

#pragma mark TTModel

- (BOOL)isLoading { 
    return FALSE;
}

- (BOOL)isLoaded {
    return TRUE;
}

- (NSInteger)numberOfPhotos {
	return _photos.count;
}

- (NSInteger)maxPhotoIndex {
	return _photos.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index {
	if (index < _photos.count) {
		id photo = [_photos objectAtIndex:index];
		if (photo == [NSNull null]) {
			return nil;
		} else {
			return photo;
		}
	} else {
		return nil;
	}
}

- (void) dealloc {
    self.title = nil;
    self.photos = nil;    
    [super dealloc];
}

@end
