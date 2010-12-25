//
//  ButterfliesPhotoSource.h
//  papillon
//
//  Created by Brit Gardner on 12/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface BirdsPhotoSource : TTModel <TTPhotoSource> {
	NSString *_title;
	NSArray *_photos;
	NSInteger *rowID;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *photos;
@property NSInteger *rowID;

@end
