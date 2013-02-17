//
// Created by twer on 1/29/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CreateUIElement.h"
#import <QuartzCore/QuartzCore.h>

@implementation CreateUIElement {

}

-(UILabel *) createLabelWithCGRect:(CGRect) rect andWithTitle:(NSString *) str {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = str;
    label.textAlignment = (NSTextAlignment) UITextAlignmentCenter;
    label.lineBreakMode = (NSLineBreakMode) UILineBreakModeWordWrap;
    return label;
}

-(UIButton *) createButtonWithCGRect:(CGRect) rect andWithTitle:(NSString *) str {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = rect;
    [button setTitle:str forState:UIControlStateNormal];
    return button;
}

-(UITextField *) createTextFieldWithCGRect:(CGRect)rect {
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    [textField setBackgroundColor:[UIColor whiteColor]];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textAlignment = (NSTextAlignment) UITextAlignmentCenter;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [[UIColor grayColor] CGColor];
    textField.layer.cornerRadius = 4.0;//Use this if you have added QuartzCore framewor
    return textField;
}

@end