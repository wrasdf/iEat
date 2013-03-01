//
//  GroupAddViewController.m
//  iOS
//
//  Created by 颛 清山 on 02/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupAddViewController.h"
#import "PlainEditTableViewCell.h"
#import "Restaurant.h"
#import "Group.h"
#import "User.h"

@interface GroupAddViewController ()
{
    NSArray *sections;
    PlainEditTableViewCell* groupNameCell;
    NSDateFormatter *formatter;
    UIViewController *datePickerController;
    UIDatePicker *datePicker;
    Group* group;

}
enum {
    SectionGroupOwner = 0,
    SectionGroupName,
    SectionRestName,
    SectionDueDate,
    SectionCount
};

@end

@implementation GroupAddViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        sections = @[@"团长", @"团名", @"餐馆", @"截止日期"];
        groupNameCell = [[PlainEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NameCell"];
        [groupNameCell.textField addTarget:self action:@selector(UpdateTitle:) forControlEvents:UIControlEventEditingChanged];
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];

        datePickerController = [[UIViewController alloc] init];
        [datePickerController setTitle:@"截止日期"];
        [[datePickerController view] setBackgroundColor:[UIColor underPageBackgroundColor]];
        datePicker = [[UIDatePicker alloc] initWithFrame:datePickerController.view.bounds];
        [datePicker addTarget:self action:@selector(selectDueDate:) forControlEvents:UIControlEventValueChanged];
        [datePickerController.view addSubview:datePicker];

        group = [[Group alloc] init];
        group.dueDate = [formatter stringFromDate:[NSDate date]];
        group.owner = [[User CurrentUser] name];
    }
    return self;
}

- (void)UpdateTitle:(UITextField *)txtField {
   self.title = txtField.text;
   group.name = txtField.text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setEditing:NO];
    self.clearsSelectionOnViewWillAppear = YES;
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
}

- (void)add:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == SectionGroupName){
        cell = groupNameCell;
    }
    else{
        static NSString *IngredientsCellIdentifier = @"PlainCell";
        cell = [tableView dequeueReusableCellWithIdentifier:IngredientsCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IngredientsCellIdentifier];
        }
        if (indexPath.section == SectionGroupOwner){
            cell.textLabel.text = group.owner;
            [cell.textLabel setTextColor:[UIColor darkGrayColor]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.section == SectionDueDate){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = group.dueDate;
        }
        else if (indexPath.section == SectionRestName){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = group.restaurant.name;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sections objectAtIndex:section];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController;
    if (indexPath.section == SectionRestName){
        viewController = [[RestaurantListViewController alloc] initWithStyle:UITableViewCellStyleDefault];
        [viewController setTitle:@"餐馆列表"];
        [(RestaurantListViewController *)viewController setRestaurant:group.restaurant];
    }
    else if (indexPath.section == SectionDueDate){
        viewController = datePickerController;
        [datePicker setDate:[formatter dateFromString:group.dueDate]];
    }
    else{
        return;
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tableView reloadData];
}

- (void)selectDueDate:(UIDatePicker *)sender {
    group.dueDate = [formatter stringFromDate:[sender date]];
    NSLog(group.dueDate);
}
@end
