//
//  SNCategoriesViewController.h
//  PaperlessPrefs
//
//  Created by nazar on 7/8/15.
//  Copyright (c) 2015 nazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCoreDataViewController.h"

@class SNCategory;

@interface SNCategoriesViewController : SNCoreDataViewController

@property (strong, nonatomic)SNCategory *category;

@end
