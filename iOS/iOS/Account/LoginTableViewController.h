//
//  LoginTableViewController.h
//  iOS
//
//  Created by 颛 清山 on 13-2-23.
//  Copyright (c) 2013年 twer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController <//UINavigationControllerDelegate,
//        UIImagePickerControllerDelegate,
        UITextFieldDelegate, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *loginFooterView;
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UIButton *signup;

- (void)sendLoginRequestWithUserName:(NSString *)username password:(NSString *)password;


@end
