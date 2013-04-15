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
#import "GroupListController.h"
#import "GroupDataService.h"
#import "Settings.h"

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController
{
    GroupListController *groupListController;
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

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        groupListController = [[GroupListController alloc] initWithStyle:UITableViewStylePlain];
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    User *currentUser = [User CurrentUser];
    if (currentUser){
        NSArray *listOfToday = [GroupDataService groupListOfToday];
        if(listOfToday != nil)
            [(UINavigationController *) [self parentViewController] pushViewController:groupListController animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
        cell.textField.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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

- (IBAction)Login:(id)sender {
    NSString *username = ((EditTableViewCell *) [[self.tableView visibleCells] objectAtIndex:0]).textField.text;
    NSString *password = ((EditTableViewCell *) [[self.tableView visibleCells] objectAtIndex:1]).textField.text;

    [self LoginWith:username password:password];
}

- (void)LoginWith:(NSString *)username password:(NSString *)password {
    if (username && password && username.length != 0 && password.length != 0) {
        [self sendLoginRequestWithUserName:username password:password];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"登录中...";
    } else {
        [[[UIAlertView alloc] initWithTitle:@"登录" message:@"Please enter user name and password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
}

- (void)sendLoginRequestWithUserName:(NSString *)username password:(NSString *)password {
    NSString *urlstring = [NSString stringWithFormat:@"%@%@", Settings.serverUri, @"/api/v1/users/sign_in"];
    NSURL *url = [NSURL URLWithString:urlstring];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setValidatesSecureCertificate:NO];
    [request setPostValue:username forKey:@"data"];
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
        NSDictionary * response = [request.responseData objectFromJSONData];
        [User SetCurrentUserName:response[@"name"] email:response[@"email"] token:response[@"token"]];
        [(UINavigationController *) [self parentViewController] pushViewController:groupListController animated:YES];

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    [super touchesBegan:touches withEvent:event];

    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"textFieldShouldReturn");

    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField1 {
//    [textField1 resignFirstResponder];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

- (void)textFieldDidEndEditing:(UITextField *)textField1 {
    [textField1 resignFirstResponder];
}


@end
