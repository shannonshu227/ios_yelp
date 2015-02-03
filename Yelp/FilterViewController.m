//
//  FilterViewController.m
//  Yelp
//
//  Created by Xiangnan Xu on 2/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "SegmentCell.h"
#import "SwitchCell.h"
#import "DropdownCell.h"
#import "CategoryViewController.h"


@interface FilterViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, CategoryViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableSet *selectedSwitches;
@property (strong, nonatomic) NSMutableArray *selectedIndexPath;
@property (strong, nonatomic) NSDictionary *filters;
@property (strong, nonatomic) NSDictionary *categoryFilters;
@property (strong, nonatomic) NSMutableArray *categorySelectedIndexPath;


@end

@implementation FilterViewController


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.categoryFilters = [NSDictionary dictionary];
        self.categorySelectedIndexPath = [NSMutableArray array];
    }
    return  self;
}

- (id)initWithFilters:(NSDictionary *) filters withSelectedIndexPath: (NSMutableArray *) selectedIndexPath {
    self = [super init];
    if (self) {
        // setup
        self.filters = filters;
        //note: it's a copy. or they will point to same address and cancel button won't work
        self.selectedIndexPath = [selectedIndexPath mutableCopy];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onSearchButton)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    [self.tableView registerNib:[UINib nibWithNibName:@"SegmentCell" bundle:nil] forCellReuseIdentifier:@"SegmentCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DropdownCell" bundle:nil] forCellReuseIdentifier:@"DropdownCellID"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Price";
            break;
        case 1:
            sectionName = @"Most Popular";
            break;
        case 2:
            sectionName = @"Distance";
            break;
        case 3:
            sectionName = @"Sort by";
            break;
        case 4:
            sectionName = @"General features";
            break;
        case 5:
            sectionName = @"Category";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row;
    switch (section) {
        case 0:
            row = 1;
            break;
        case 1:
            row = 4;
            break;
        case 2:
            row = 1;
            break;
        case 3:
            row = 1;
            break;
        case 4:
            row = 3;
            break;
        case 5:
            row = 1;
            break;
        default:
            break;
            
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (indexPath.section == 0) {
        SegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegmentCellID"];
        return cell;
        
    } else if (indexPath.section == 1) {
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCellID"];
        NSString *labelText;
        if (indexPath.row == 0) {
            labelText = @"Open Now";
            bool state = [cell.switchButton isOn];
            NSLog(@"%d", state);
        } else if (indexPath.row == 1) {
            labelText = @"Hot & New";
            
        } else if (indexPath.row == 2) {
            labelText = @"Offering a Deal";
            
        } else {
            labelText = @"Delivery";
        }
        cell.switchLabel.text = labelText;
        //        cell.switchButton.tag = indexPath.section * 6 + indexPath.row;
        //
        //        NSString *initState = [defaults objectForKey:[NSString stringWithFormat:@"%ld", cell.switchButton.tag]];
        //        if ([initState isEqualToString:@"yes"]) {
        //            [cell.switchButton setOn:YES];
        //        } else {
        //            [cell.switchButton setOn:NO];
        //        }
        //
        //
        //        [cell.switchButton addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventTouchUpInside];
        
        if([self.selectedIndexPath containsObject:indexPath]) {
            cell.on = TRUE;
        } else {
            cell.on = FALSE;
        }
        
        cell.delegate = self;
        return cell;
        
    } else if (indexPath.section == 2) {
        DropdownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropdownCellID"];
        cell.dropdownLabel.text = @"Auto";
        cell.dropdownTriangleLabel.text = @"\u25BE";
        return cell;
        
    } else if (indexPath.section == 3) {
        DropdownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropdownCellID"];
        cell.dropdownLabel.text = @"Best Match";
        cell.dropdownTriangleLabel.text = @"\u25BE";
        
        return cell;
    } else if (indexPath.section == 4){
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCellID"];
        
        NSString *labelText;
        if (indexPath.row == 0) {
            labelText = @"Take-out";
        } else if (indexPath.row == 1) {
            labelText = @"Good for Groups";
            
        } else {
            labelText = @"Takes Reservations";
            
        }
        cell.switchLabel.text = labelText;
        //        cell.switchButton.tag = indexPath.section * 6 + indexPath.row;
        //
        //        NSString *initState = [defaults objectForKey:[NSString stringWithFormat:@"%ld", cell.switchButton.tag]];
        //        if ([initState isEqualToString:@"yes"]) {
        //            [cell.switchButton setOn:YES];
        //        } else {
        //            [cell.switchButton setOn:NO];
        //        }
        //        [cell.switchButton addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventTouchUpInside];
        if([self.selectedIndexPath containsObject:indexPath]) {
            cell.on = TRUE;
        } else {
            cell.on = FALSE;
        }
        
        
        cell.delegate = self;
        return cell;
        
    } else {
        DropdownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropdownCellID"];
        
        //cell.dropdownLabel.text = @"Afghan";
        //cell.dropdownTriangleLabel.text = @"\u25BE";
        cell.dropdownLabel.text = @"Click to see all";
        cell.dropdownTriangleLabel.text = @"";
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor clearColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor grayColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}



//- (IBAction)switchChanged:(id)sender
//{
//    NSInteger section = [sender tag] / 6;
//    NSInteger row = [sender tag] % 6;
//    NSLog(@"section, %ld, row, %ld", section, row);
//    
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//        if ([sender isOn] == true) {
//            NSString *state = @"yes";
//            NSLog(@"%@", state);
//            [defaults setObject:state forKey:[NSString stringWithFormat:@"%ld", [sender tag]]];
//        } else {
//            NSString *state = @"no";
//            [defaults setObject:state forKey:[NSString stringWithFormat:@"%ld", [sender tag]]];
//        }
//        [defaults synchronize];
//    
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2 && indexPath.row == 0) {
       //handle dropdown list for distance
    }
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        //handle dropdown list for sortby
    }
    
    if (indexPath.section == 5 && indexPath.row == 0) {
        
        CategoryViewController *vc = [[CategoryViewController alloc] initWithCategories:self.categoryFilters withSelectedIndexPath:self.categorySelectedIndexPath];
        vc.delegate = self;
        
        //to have navigation bar, have to embed navigation controller inside view controller
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nvc animated:YES completion:nil];
    }
    
}


- (void) switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if(value) {
        NSLog(@"yes");
        [self.selectedIndexPath addObject:indexPath];
    } else {
        NSLog(@"no");
        [self.selectedIndexPath removeObject:indexPath];
    }
}


- (void) onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onSearchButton {
    [self.delegate filterViewController:self didChangeFilters:self.filters atIndexPath:self.selectedIndexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) categoryViewController:(CategoryViewController *) categoryViewController didChangeCategories:(NSDictionary *) filters atIndexPath:(NSMutableArray *) selectedIndexPath {
    NSLog(@"category change...");
    self.categoryFilters = filters;
    self.categorySelectedIndexPath = selectedIndexPath;
}

@end
