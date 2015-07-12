//
//  SNCategoriesViewController.m
//  PaperlessPrefs
//
//  Created by nazar on 7/8/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import "SNCategoriesViewController.h"
#import "SNCategories.h"
#import "SNDataManager.h"
#import "SNCategory.h"
#import "SNUpSideBarTableCell.h"
#import "SNDownSideBarTableCell.h"

@interface SNCategoriesViewController ()


@end

@implementation SNCategoriesViewController
@synthesize favoritesFetchedResultsController = _favoritesFetchedResultsController;
@synthesize nonFavoritesFetchedResultsController = _nonFavoritesFetchedResultsController;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.editing = YES;
    
    
    static NSString *cellIdentifierDown = @"downSideBarTableCell";
    static NSString *cellIdentifierUp = @"upSideBarTableCell";
    
    UINib *nib = [UINib nibWithNibName:@"SNDownSIdeBarTableCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifierDown];
    
    nib = [UINib nibWithNibName:@"SNUpSideBarTableCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifierUp];
    
    self.tableView.contentInset = UIEdgeInsetsMake(20.f, 0.f, 20.f, 0.f);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(20.f, 0.f, 0.f, 0.f);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)favoritesFetchedResultsController
{
    if (_favoritesFetchedResultsController != nil) {
        return _favoritesFetchedResultsController;

    }
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"SNCategory"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"orderIndex" ascending:YES];
    SNCategories *fav;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite = %@",fav];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    
    // Edit the section name key path and cache name if appropriate.
    
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    
  //  NSLog(@"%@",self.fetchedResultsController.sectionNameKeyPath);

    aFetchedResultsController.delegate = self;
    self.favoritesFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.favoritesFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _favoritesFetchedResultsController;
}

- (NSFetchedResultsController *)nonFavoritesFetchedResultsController
{
    if (_nonFavoritesFetchedResultsController != nil) {
        return _nonFavoritesFetchedResultsController;
    }
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"SNCategory"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"orderIndex" ascending:YES];
    SNCategories *non;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nonFavorite = %@",non];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    
    // Edit the section name key path and cache name if appropriate.
    
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    //  NSLog(@"%@",self.fetchedResultsController.sectionNameKeyPath);
    
    aFetchedResultsController.delegate = self;
    self.nonFavoritesFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.nonFavoritesFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
    return _nonFavoritesFetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"downSideBarTableCell";
    static NSString *identifier2 = @"upSideBarTableCell";
    
    if (indexPath.section == 0) {
           SNDownSideBarTableCell *cell = (SNDownSideBarTableCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        SNCategory *favCategory = [self.favoritesFetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        cell.downButton.tag = indexPath.row;
        [cell.downButton addTarget:self action:@selector(downCategory:) forControlEvents:UIControlEventTouchUpInside];
        cell.downTextLabel.text = favCategory.name;
        return cell;

    }else if (indexPath.section == 1) {
         SNUpSideBarTableCell *cell = (SNUpSideBarTableCell*)[tableView dequeueReusableCellWithIdentifier:identifier2];
        
        SNCategory *nonFavCategory = [self.nonFavoritesFetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];

        cell.upButton.tag = indexPath.row;
        [cell.upButton addTarget:self action:@selector(upCategory:) forControlEvents:UIControlEventTouchUpInside];
        cell.upTextLabel.text = nonFavCategory.name;
        return cell;
        
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];
    
    if (section == 0) {
        
        NSString *favored = @"Favored";
        [label setText:favored];

    }else if (section == 1) {
    
    NSString *nonFavored = @"Non-Favored";
        [label setText:nonFavored];

    }
    return view;


    
}

-(void)downCategory:(UIButton*)button {
    NSInteger index = button.tag;
    NSLog(@"%lu",index);
    [self deleteObjectAtIndex:index];
}

-(void)upCategory:(UIButton*)button {
    [self.tableView reloadData];

    NSInteger index = button.tag;
    NSLog(@"%lu",index);
    NSIndexPath *fromIndexPath = [[NSIndexPath alloc] initWithIndex:index];
    fromIndexPath = [NSIndexPath indexPathForRow:index inSection:1];
    
   
    NSInteger count = [self.favoritesFetchedResultsController.fetchedObjects count];
    NSIndexPath *toIndexPath = [[NSIndexPath alloc] init];
    toIndexPath = [NSIndexPath indexPathForRow:count inSection:0];
    
    //[self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    
    
    // [self.tableView reloadData];
  //  [self.tableView deleteRowsAtIndexPaths:@[fromIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    //  [self.tableView insertRowsAtIndexPaths:@[toIndexPath] withRowAnimation:UITableViewRowAnimationFade];

    
    
}

-(void)deleteObjectAtIndex:(NSInteger)index {

    NSError *error = nil;
    
    NSManagedObjectContext *context = [self.favoritesFetchedResultsController managedObjectContext];
    NSInteger toIndex = [self.favoritesFetchedResultsController.fetchedObjects count];
    //[context deleteObject:[self.nonFavoritesFetchedResultsController.fetchedObjects objectAtIndex:index]];
    SNCategories *categories;
    SNCategory *category = [self.favoritesFetchedResultsController.fetchedObjects objectAtIndex:index];
    NSLog(@"cat name%@",category.name);
    //[categories insertObject:category inNonFavoritesAtIndex:toIndex+1];
    //[context objectWithID:<#(NSManagedObjectID *)#>];
    
   
    [context save:nil];
    
    
}



#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    
    //SNCategory *category = [self.favoritesFetchedResultsController.fetchedObjects objectAtIndex:<#(NSUInteger)#>];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 61.f;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return YES;
    }else  {
        return NO;
    }
    
}

-(NSIndexPath*)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {

    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    ASUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    ASCoursesViewController* vc = [[ASCoursesViewController alloc] init];
    vc.university = university;
    
    [self.navigationController pushViewController:vc animated:YES];
     */
}


@end
