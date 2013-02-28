//
//  GroupDetailViewController.m
//  iOS
//
//  Created by 颛 清山 on 02/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "PlainEditTableViewCell.h"
#import "RestaurantListViewController.h"

@interface GroupDetailViewController ()
{
    NSArray *sections;
    PlainEditTableViewCell* groupNameCell;
    NSString *dueDate;
    NSString *groupName;
    NSString *restName;
    NSString *owner;
    NSDateFormatter *formatter;
    UIViewController *datePickerController;
    UIDatePicker *datePicker;

}
enum {
    SectionGroupName = 0,
    SectionRestName,
    SectionDueDate,
    SectionCount
};

@end

@implementation GroupDetailViewController
@synthesize dueDate;
@synthesize restName;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        sections = @[@"团名", @"餐馆", @"截止日期"];
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

        dueDate = [formatter stringFromDate:[NSDate date]];
    }
    return self;
}

- (void)UpdateTitle:(UITextField *)textfield {
   self.title = textfield.text;
   groupName = textfield.text;
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
//            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        if (indexPath.section == SectionDueDate){
            cell.textLabel.text = dueDate;
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
    } else if (indexPath.section == SectionDueDate){
        viewController = datePickerController;
        [datePicker setDate:[formatter dateFromString:dueDate]];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)selectDueDate:(UIDatePicker *)sender {
    dueDate = [formatter stringFromDate:[sender date]];
    NSLog(dueDate);
    [[self tableView] reloadData];
}

@end
