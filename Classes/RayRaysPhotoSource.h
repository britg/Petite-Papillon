//
//  RayRaysPhotoSource.h
//  papillon
//
//  Created by Brit Gardner on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface RayRaysPhotoSource : TTModel <TTPhotoSource> {
	NSString *_title;
	NSArray *_photos;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *photos;

+ (RayRaysPhotoSource *)samplePhotoSet;

@end
