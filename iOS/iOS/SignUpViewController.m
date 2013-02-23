//
//  SignUpViewController.m
//  iOS
//
//  Created by 颛 清山 on 13-2-23.
//  Copyright (c) 2013年 twer. All rights reserved.
//

#import "SignUpViewController.h"
#import "EditTableViewCell.h"

@interface SignUpViewController ()
 enum{
     UserNameCell = 0,
     EmailCell,
     PasswordCell,
     PasswordConfirmCell,
     CellCount
 } ;
@end

@implementation SignUpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    UIButton *ok = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ok.frame = CGRectMake(30, 10, 100, 44);
    [ok setTitle:@"OK" forState:UIControlStateNormal];
    [ok addTarget:self action:@selector(Ok) forControlEvents:UIControlEventTouchUpInside];

    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancel.frame = CGRectMake(190, 10, 100, 44);
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];


    [footer addSubview:ok];
    [footer addSubview:cancel];

    self.tableView.tableFooterView = footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"SignUp";
}

- (void)Cancel {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)Ok {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SignupCell";
    EditTableViewCell *cell = (EditTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    if (indexPath.row == UserNameCell) {
        cell.label.text = @"Name";
        cell.textField.text = @"";
        cell.textField.placeholder = @"Name";
    }
    else if (indexPath.row == EmailCell) {
        cell.label.text = @"Email";
        cell.textField.text = @"";
        cell.textField.placeholder = @"Email";
    }
    else if (indexPath.row == PasswordCell){
        cell.label.text = @"Password";
        cell.textField.clearButtonMode = cell.textField.secureTextEntry = YES;
    }
    else if (indexPath.row == PasswordConfirmCell){
        cell.label.text = @"Confirm";
        cell.textField.clearButtonMode = cell.textField.secureTextEntry = YES;
    }

    return cell;
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
