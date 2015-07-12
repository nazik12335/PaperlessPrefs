//
//  SNCoreDataViewController.h
//  PaperlessPrefs
//
//  Created by nazar on 7/7/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SNCoreDataViewController : UITableViewController <NSFetchedResultsControllerDelegate>

{
    BOOL changingFavoritesOrder;
}

@property (strong, nonatomic) NSFetchedResultsController *favoritesFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *nonFavoritesFetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
