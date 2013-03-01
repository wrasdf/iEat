//
//  LoginTableViewController.m
//  iOS
//
//  Created by 颛 清山 on 13-2-23.
//  Copyright (c) 2013年 twer. All rights reserved.
//

#import "LoginTableViewController.h"
#import "EditTableViewCell.h"
#import "SignUpViewController.h"
#import "User.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController
{
}
@synthesize loginFooterView;

enum {
    SectionLogin = 0,
    SectionCount
};
enum {
    CellUser = 0,
    CellPassword = 1,
    CellCount

};

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (loginFooterView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"LoginFooterView" owner:self options:nil];
        self.tableView.tableFooterView = loginFooterView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"登录";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *EditCellIdentifier = @"LoginCell";

    EditTableViewCell *cell = (EditTableViewCell *) [tableView dequeueReusableCellWithIdentifier:EditCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    if (indexPath.section == SectionLogin) {
        if (indexPath.row == CellUser) {
            cell.label.text = @"用户";
            cell.textField.text = @"";
            cell.textField.placeholder = @"请输入你的用户名或Email";
        }
        else if (indexPath.row == CellPassword) {
            cell.label.text = @"密码";
            cell.textField.text = @"";
            cell.textField.clearButtonMode = cell.textField.secureTextEntry = YES;
            cell.textField.placeholder = @"请输入你的密码";
        }
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
- (IBAction)Login:(id)sender {
    NSString *username = ((EditTableViewCell *) [[self.tableView visibleCells] objectAtIndex:0]).textField.text;
    NSString *password = ((EditTableViewCell *) [[self.tableView visibleCells] objectAtIndex:1]).textField.text;

    if (username && password && username.length != 0 && password.length != 0) {
        [self sendLoginRequestWithUserName:username password:password];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"登录中...";
    } else {
        [[[UIAlertView alloc] initWithTitle:@"登录" message:@"Please enter user name and password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
}

- (void)sendLoginRequestWithUserName:(NSString *)username password:(NSString *)password {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/api/v1/users/sign_in"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"email"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        NSLog(@"return 400");
    } else if (request.responseStatusCode == 403) {
        NSLog(@"return 403");
    } else if (request.responseStatusCode == 200) {
//        NSString *username = ((EditTableViewCell *) [[self.tableView visibleCells] objectAtIndex:0]).textField.text;
        NSDictionary * response = [request.responseData objectFromJSONData];
        [User SetCurrentUserName:response[@"email"] token:response[@"token"]];
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        NSLog(@"Unexpected error");
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(error.localizedDescription);
}

- (IBAction)SignUp:(id)sender {
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self presentViewController: signUpViewController animated:YES completion:NULL];
}
@end
