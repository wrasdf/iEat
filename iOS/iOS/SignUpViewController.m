//
//  SignUpViewController.m
//  iOS
//
//  Created by 颛 清山 on 13-2-23.
//  Copyright (c) 2013年 twer. All rights reserved.
//

#import "SignUpViewController.h"
#import "EditTableViewCell.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "User.h"
#import "Settings.h"

@interface SignUpViewController ()
 enum{
     UserNameCell = 0,
     EmailCell,
     PhoneCell,
     PasswordCell,
     PasswordConfirmCell,
     CellCount
 } ;
@end

@implementation SignUpViewController
{
    NSString * userName;
    NSString * password;
    NSString * email;
    NSString * confirmPassword;
    NSString * phoneNumber;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    UIButton *ok = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ok.frame = CGRectMake(30, 10, 100, 44);
    [ok setTitle:@"提交" forState:UIControlStateNormal];
    [ok addTarget:self action:@selector(Ok) forControlEvents:UIControlEventTouchUpInside];

    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancel.frame = CGRectMake(190, 10, 100, 44);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];


    [footer addSubview:ok];
    [footer addSubview:cancel];

    self.tableView.tableFooterView = footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"注册一个";
}

- (void)Cancel {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)Ok {
    if ([userName length] && [password length] && [email length] && [password isEqualToString:confirmPassword] && [phoneNumber length]){
        [self sendSignUpMessage];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"注册中...";
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check input info." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }
}

- (void)sendSignUpMessage {
    //Start request
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [Settings serverUri] , @"/api/v1/users"];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setValidatesSecureCertificate:NO];
    [request setPostValue:userName forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setPostValue:password forKey:@"password_confirmation"];
    [request setPostValue:email forKey:@"email"];
    [request setPostValue:phoneNumber forKey:@"telephone"];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startAsynchronous];
    NSLog([request responseString]);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        NSLog(@"return 400");
    } else if (request.responseStatusCode == 403) {
        NSLog(@"return 403");
    } else if (request.responseStatusCode == 200) {
        [User SetCurrentUserName:userName email: nil token:NULL];
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
        cell.textField.delegate = self;
    }
    if (indexPath.row == UserNameCell) {
        cell.label.text = @"用户名";
        cell.textField.text = @"";
        cell.textField.placeholder = @"用户名";
        [cell.textField addTarget:self action:@selector(CheckUsername:) forControlEvents:UIControlEventEditingChanged];

    }
    if (indexPath.row == PhoneCell) {
        cell.label.text = @"电话";
        cell.textField.text = @"";
        cell.textField.placeholder = @"请输入你的手机号";
        [cell.textField addTarget:self action:@selector(CheckPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

    }
    else if (indexPath.row == EmailCell) {
        cell.label.text = @"Email";
        cell.textField.text = @"";
        cell.textField.placeholder = @"yourname@domain.com";
        [cell.textField addTarget:self action:@selector(CheckMail:) forControlEvents:UIControlEventEditingChanged];
    }
    else if (indexPath.row == PasswordCell){
        cell.label.text = @"密码";
        cell.textField.placeholder = @"不少于6个字符";
        cell.textField.clearButtonMode = cell.textField.secureTextEntry = YES;
        [cell.textField addTarget:self action:@selector(CheckPassword:) forControlEvents:UIControlEventEditingChanged];

    }
    else if (indexPath.row == PasswordConfirmCell){
        cell.label.text = @"密码确认";
        cell.textField.placeholder = @"不少于6个字符";
        cell.textField.clearButtonMode = cell.textField.secureTextEntry = YES;
        [cell.textField addTarget:self action:@selector(ConfirmPassword:) forControlEvents:UIControlEventEditingChanged];

    }
    cell.textField.delegate = self;

    return cell;
}

- (void)CheckPhoneNumber:(UITextField *)textField {
    if ([[textField text] length] <= 0){
//        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please input phone number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//        [textField setTextColor:[UIColor redColor] ];
        [textField setBackgroundColor:[UIColor redColor]];
        phoneNumber = @"";
        return;
    }
    phoneNumber = textField.text;
    [textField setTextColor:[UIColor darkTextColor] ];
    [textField setBackgroundColor:[UIColor groupTableViewBackgroundColor]];

}

- (void)CheckUsername:(UITextField *)textField {
   if ([[textField text] length] <= 0){
//       [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please input username" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//       [textField setTextColor:[UIColor redColor] ];
       [textField setBackgroundColor:[UIColor redColor]];

       userName = @"";
       return;
   }
    userName = textField.text;
    [textField setTextColor:[UIColor darkTextColor] ];
    [textField setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)CheckPassword:(UITextField *)textField {
   if ([[textField text] length]<6){
       [textField setTextColor:[UIColor redColor] ];
       password = @"";
       return;
   }
    password = textField.text;
    [textField setTextColor:[UIColor darkTextColor] ];
}

- (void)ConfirmPassword:(UITextField *)textField {
   if (password && ![textField.text isEqualToString:password]){
       [textField setTextColor:[UIColor redColor] ];
       confirmPassword = @"";
       return;
   }
   if ([[textField text] length]<6){
       [textField setTextColor:[UIColor redColor] ];
       confirmPassword = @"";
       return;
   }
    confirmPassword = textField.text;
    [textField setTextColor:[UIColor darkTextColor] ];
}

- (void)CheckMail:(UITextField*)textField {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    BOOL isValid = [emailTest evaluateWithObject:textField.text];
    if (!isValid){
        [textField setTextColor:[UIColor redColor] ];
        email = @"";
        return;
    }
    email = textField.text;
    [textField setTextColor:[UIColor darkTextColor] ];
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
