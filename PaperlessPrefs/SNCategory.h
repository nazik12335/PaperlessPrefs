//
//  SNCategory.h
//  PaperlessPrefs
//
//  Created by nazar on 7/9/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SNCategories;

@interface SNCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) SNCategories *favorite;
@property (nonatomic, retain) SNCategories *nonFavorite;

@end
