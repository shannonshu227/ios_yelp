//
//  DropdownCell.h
//  Yelp
//
//  Created by Xiangnan Xu on 2/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dropdownLabel;

@property (weak, nonatomic) IBOutlet UILabel *dropdownTriangleLabel;
@end
