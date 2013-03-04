//
//  GroupDetailsViewController.m
//  iOS
//
//  Created by 颛 清山 on 03/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import "LLRoundSwitch.h"

@interface GroupDetailsViewController ()
{
    enum {
        SectionDesc = 0,
        SectionStatus,
        SectionCount
    };
    NSArray *sections;
    NSArray *restDesc;
}
@end

@implementation GroupDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        sections = @[@"餐馆简介", @"饭团信息", @"王锐", @"明心"];
        restDesc = @[@"饭店名称", @"订餐电话", @"外卖时间", @"起送金额"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SectionDesc){
        return 30.0;
    }
    else return 60;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SectionDesc)
        return [restDesc count];
    if (section == SectionStatus)
        return 0;
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if(section > SectionStatus) return nil;
    return [sections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section>SectionStatus)
    {
        return 40;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)path {
   if (path.section == SectionDesc)
   {
       cell.textLabel.text = [restDesc objectAtIndex:path.row];
       [cell.textLabel setTextColor:[UIColor grayColor]];
       [cell.textLabel setFont:[UIFont systemFontOfSize:12.0]];
   }
   else if (path.section>SectionDesc){
       if (path.row== 0){
           LLRoundSwitch *roundSwitch = [[LLRoundSwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
           [roundSwitch setOffText:@"详细"];
           [roundSwitch setOnText:@"详细"];
           [roundSwitch addTarget:self action:@selector(hintSwitchChanged:) forControlEvents:UIControlEventValueChanged];
           cell.accessoryView = roundSwitch;
           cell.textLabel.text = @"王锐 12￥";
           cell.detailTextLabel.text = @"牛肉香菜 2两";
           cell.detailTextLabel.numberOfLines=0;
           [cell.detailTextLabel setAutoresizesSubviews:YES];
           [cell setIndentationLevel:0];
       }
   }
}

- (void)hintSwitchChanged:(LLRoundSwitch *)sender  {
//    NSArray *indexes = [NSArray arrayWithObjects:
//            [NSIndexPath indexPathForRow:1 inSection:3],
//            [NSIndexPath indexPathForRow:2 inSection:3],
//            nil];
//    if (sender.on)
//    {
//        [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//    else
//    {
//        [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
