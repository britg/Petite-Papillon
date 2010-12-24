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

static RayRaysPhotoSource *samplePhotoSet = nil;

+ (RayRaysPhotoSource *) samplePhotoSet {
    @synchronized(self) {
        if (samplePhotoSet == nil) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *pathToDocuments=[paths objectAtIndex:0];
			NSString *pathToImage = [NSString stringWithFormat:@"document:/%@", [pathToDocuments stringByAppendingPathComponent:@"rayrays/123.png"]];
			
			DebugLog(@"path to image is %@", pathToImage);
			
			NSError *error;
			NSFileManager *fileMgr = [NSFileManager defaultManager];
			NSString *pathToRayRays = [pathToDocuments stringByAppendingPathComponent:@"rayrays/"];
			// Write out the contents of home directory to console
			DebugLog(@"rays rays directory: %@", [fileMgr contentsOfDirectoryAtPath:pathToRayRays error:&error]);
			
            Photo *sampleImage = [[[Photo alloc] initWithCaption:@"" 
                                                      urlLarge:@"documents://rayrays/123.png"
                                                      urlSmall:@"documents://rayrays/123.png"  
                                                      urlThumb:@"documents://rayrays/123.png"
                                                          size:CGSizeMake(1024, 768)] autorelease];
            NSArray *photos = [NSArray arrayWithObjects:sampleImage, nil];
            samplePhotoSet = [[self alloc] initWithTitle:@"RayRays" photos:photos];
        }
    }
    return samplePhotoSet;
}

@end
