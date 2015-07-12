//
//  SNDataManager.m
//  PaperlessPrefs
//
//  Created by nazar on 7/7/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import "SNDataManager.h"
#import "SNCategories.h"
#import "SNCategory.h"

@interface SNDataManager ()

@property (weak, nonatomic) SNCategories *categories;

@end

@implementation SNDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+(SNDataManager*)sharedManager {

    static SNDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SNDataManager alloc] init];
    });

    return manager;
    
}

-(void)add {
   /* [self deleteAllObjects];
    self.categories = [self addCategories];
    
    

    [self addFavoriteCategoryWithName:@"World"];
    [self addFavoriteCategoryWithName:@"Sport"];
    [self addFavoriteCategoryWithName:@"Politics"];
    [self addFavoriteCategoryWithName:@"Tech"];
    
    [self addNonFavoriteCategoryWithName:@"Social F"];
    [self addNonFavoriteCategoryWithName:@"Ukraine"];
    [self addNonFavoriteCategoryWithName:@"Fashion"];
    [self addNonFavoriteCategoryWithName:@"Health"];
    [self addNonFavoriteCategoryWithName:@"Culture"];

    

   // NSEntityDescription *description = [NSEntityDescription entityForName:@"SNCategories" inManagedObjectContext:self.managedObjectContext];
    //SNCategories *categ = [[SNCategories alloc] initWithEntity:description insertIntoManagedObjectContext:self.managedObjectContext];
    //SNCategory *category = [self addCategoryWithName:@"ето победа !"];
    //[categ replaceObjectInFavoritesAtIndex:2 withObject:category];
 //   [self.managedObjectContext save:nil];

    [self print];
    //[self change];

   // [self addNonFavoriteCategoryWithName:@"Music"];
   // [self print];
*/
   
}

-(void)addNewCategory {
    [self addNonFavoriteCategoryWithName:@"Music"];

}
-(void)print {

    NSArray *resultArray = [self allObjects];
       NSLog(@"COUNT %lu",[resultArray count]);
    for (SNCategory *category in resultArray) {
        NSLog(@"%@, index %lu",category.name,[category.orderIndex integerValue]);
    }
   // SNCategory *category = [resultArray objectAtIndex:1];
    //NSLog(@"%@",category.name);

}

-(NSArray*)allObjects {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"SNCategory" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSError *requestError = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }

    return resultArray;
}

-(void)change {
/*
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"SNCategories" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    SNCategory *category = [resultArray objectAtIndex:1];
    NSLog(@"fetched category %@",category.name);
   // SNCategory *category = [self addCategoryWithName:@"Woooah cateory at index 0"];
    //[categories replaceObjectInFavoritesAtIndex:0 withObject:category];
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    */

    
    
    
    
}

-(void)deleteAllObjects {

    NSArray *allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}

-(SNCategories*)addCategories {

    SNCategories *categories = [NSEntityDescription insertNewObjectForEntityForName:@"SNCategories" inManagedObjectContext:self.managedObjectContext];
    
 //  NSManagedObjectID *moID = [self.managedObjectContext objec];
   // moID = [SNCategories objectId];
    return categories;

}
-(void)addFavoriteCategoryWithName:(NSString*)name {

    SNCategory *category = [NSEntityDescription insertNewObjectForEntityForName:@"SNCategory" inManagedObjectContext:self.managedObjectContext];
    category.name = name;
    
    [self.categories addFavoritesObject:category];
    [self.managedObjectContext save:nil];


}
-(void)addNonFavoriteCategoryWithName:(NSString*)name {

    SNCategory *category = [NSEntityDescription insertNewObjectForEntityForName:@"SNCategory" inManagedObjectContext:self.managedObjectContext];
    category.name = name;
    
    [self.categories addNonFavoritesObject:category];
    [self.managedObjectContext save:nil];
}


- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "SN.PaperlessPrefs" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PaperlessPrefs" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PaperlessPrefs.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
