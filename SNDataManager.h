//
//  SNDataManager.h
//  PaperlessPrefs
//
//  Created by nazar on 7/7/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SNDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(SNDataManager*)sharedManager;
- (void)saveContext;
-(void)add;
-(void)addNewCategory;

@end
