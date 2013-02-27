//
//  GroupDetailViewController.m
//  iOS
//
//  Created by 颛 清山 on 02/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "PlainEditTableViewCell.h"

@interface GroupDetailViewController ()
{
    NSArray *sections;
    PlainEditTableViewCell* groupNameCell;

}
enum {
    SectionGroupName = 0,
    SectionRestName,
    SectionDueDate,
    SectionCount
};

@end

@implementation GroupDetailViewController
@synthesize groupNameCell;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView setEditing:NO];
        sections = @[@"团名", @"餐馆", @"截止日期"];
        groupNameCell = [[PlainEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NameCell"];
        [groupNameCell.textField addTarget:self action:@selector(UpdateTitle:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)UpdateTitle:(UITextField *)textfield {
   self.title = textfield.text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.clearsSelectionOnViewWillAppear = YES;
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(add:)];

    self.navigationItem.rightBarButtonItem = addButtonItem;
}

- (void)add:(id)sender {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sections objectAtIndex:section];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
