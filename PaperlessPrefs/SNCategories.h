//
//  SNCategories.h
//  PaperlessPrefs
//
//  Created by nazar on 7/9/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SNCategory;

@interface SNCategories : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *favorites;
@property (nonatomic, retain) NSOrderedSet *nonFavorites;
@end

@interface SNCategories (CoreDataGeneratedAccessors)

- (void)insertObject:(SNCategory *)value inFavoritesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFavoritesAtIndex:(NSUInteger)idx;
- (void)insertFavorites:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFavoritesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFavoritesAtIndex:(NSUInteger)idx withObject:(SNCategory *)value;
- (void)replaceFavoritesAtIndexes:(NSIndexSet *)indexes withFavorites:(NSArray *)values;
- (void)addFavoritesObject:(SNCategory *)value;
- (void)removeFavoritesObject:(SNCategory *)value;
- (void)addFavorites:(NSOrderedSet *)values;
- (void)removeFavorites:(NSOrderedSet *)values;

- (void)insertObject:(SNCategory *)value inNonFavoritesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromNonFavoritesAtIndex:(NSUInteger)idx;
- (void)insertNonFavorites:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeNonFavoritesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInNonFavoritesAtIndex:(NSUInteger)idx withObject:(SNCategory *)value;
- (void)replaceNonFavoritesAtIndexes:(NSIndexSet *)indexes withNonFavorites:(NSArray *)values;
- (void)addNonFavoritesObject:(SNCategory *)value;
- (void)removeNonFavoritesObject:(SNCategory *)value;
- (void)addNonFavorites:(NSOrderedSet *)values;
- (void)removeNonFavorites:(NSOrderedSet *)values;

@end
