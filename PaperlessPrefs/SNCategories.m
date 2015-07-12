//
//  SNCategories.m
//  PaperlessPrefs
//
//  Created by nazar on 7/9/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import "SNCategories.h"
#import "SNCategory.h"


@implementation SNCategories

@dynamic favorites;
@dynamic nonFavorites;

-(void)addNonFavoritesObject:(SNCategory *)value {
    
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.nonFavorites];
    NSNumber *index = [NSNumber numberWithInteger:[self.nonFavorites count]];
    NSLog(@"non %lu",[self.nonFavorites count]);

    value.orderIndex = index;
    [tempSet addObject:value];
    self.nonFavorites = tempSet;
}

- (void)addFavoritesObject:(SNCategory *)value {
    
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.favorites];
    NSNumber *index = [NSNumber numberWithInteger:[self.favorites count]];
    NSLog(@"fav %lu",[self.favorites count]);
    
    value.orderIndex = index;
    [tempSet addObject:value];
    self.favorites = tempSet;
}




- (void)insertObject:(SNCategory *)value inFavoritesAtIndex:(NSUInteger)idx {
    
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.favorites];
    
    NSNumber *index = [NSNumber numberWithInteger:idx];
    value.orderIndex = index;
    
    [tempSet insertObject:value atIndex:idx];
    self.favorites = tempSet;
    
}

-(void)insertObject:(SNCategory *)value inNonFavoritesAtIndex:(NSUInteger)idx {
    
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.nonFavorites];
    
    NSNumber *index = [NSNumber numberWithInteger:idx];
    value.orderIndex = index;
    
    [tempSet insertObject:value atIndex:idx];
    self.nonFavorites = tempSet;
}

- (void)replaceObjectInFavoritesAtIndex:(NSUInteger)idx withObject:(SNCategory *)value {
    
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.favorites];
    [tempSet replaceObjectAtIndex:idx withObject:value];
    self.favorites = tempSet;
    
}


@end
