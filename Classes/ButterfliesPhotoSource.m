//
//  RayRaysPhotoSource.m
//  papillon
//
//  Created by Brit Gardner on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ButterfliesPhotoSource.h"
#import "Photo.h"


@implementation ButterfliesPhotoSource
@synthesize title = _title;
@synthesize photos = _photos;
@synthesize rowID;

- (id) initWithRowID:(NSInteger)_rowID {
	self = [super init];
	self.rowID = _rowID;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathToDocuments=[paths objectAtIndex:0];
	
	NSError *error;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSString *pathToRayRays = [pathToDocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"butterflies/%i", self.rowID]];
	NSArray *rayRayContents = [fileMgr contentsOfDirectoryAtPath:pathToRayRays error:&error];
	NSString *pathToRayRayThumbs = [pathToDocuments stringByAppendingPathComponent:[NSString stringWithFormat:@"butterfly_thumbs/%i", self.rowID]];
	NSArray *rayRayThumbContents = [fileMgr contentsOfDirectoryAtPath:pathToRayRays error:&error];
	
	// Write out the contents of home directory to console
	DebugLog(@"butterflies directory %@: %@",pathToRayRays, rayRayContents);
	DebugLog(@"butterfly thumbs directory %@: %@",pathToRayRayThumbs, rayRayThumbContents);
	
	NSMutableArray *tempPhotos = [[[NSMutableArray alloc] init] autorelease];
	
	for (int i=0; i < rayRayContents.count; i++) {
		NSString *path = [NSString stringWithFormat:@"documents://butterflies/%i/%@",self.rowID, [rayRayContents objectAtIndex:i]];
		NSString *thumbPath = [NSString stringWithFormat:@"documents://butterfly_thumbs/%i/%@", self.rowID, [rayRayContents objectAtIndex:i]];
		DebugLog(@"butterfly thumb path is: %@", thumbPath);
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
