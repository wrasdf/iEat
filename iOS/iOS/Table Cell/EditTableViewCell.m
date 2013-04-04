//
//  EditTableViewCell.m
//  iOS
//
//  Created by 颛 清山 on 13-2-23.
//  Copyright (c) 2013年 twer. All rights reserved.
//

#import "EditTableViewCell.h"

@implementation EditTableViewCell

@synthesize label, textField;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField1 {
    [textField1 resignFirstResponder];
    return YES;
}

@end
