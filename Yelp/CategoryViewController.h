//
//  CategoryViewController.h
//  Yelp
//
//  Created by Xiangnan Xu on 2/2/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryViewController;
@protocol CategoryViewControllerDelegate <NSObject>

- (void) categoryViewController:(CategoryViewController *) categoryViewController didChangeCategories:(NSDictionary *) filters atIndexPath:(NSMutableArray *) selectedIndexPath;


@end

@interface CategoryViewController : UIViewController
@property (weak, nonatomic) id<CategoryViewControllerDelegate> delegate;
- (id)initWithCategories:(NSDictionary *) filters withSelectedIndexPath: (NSMutableArray *) selectedIndexPath;
@end
