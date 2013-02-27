//
//  PlainEditTableViewCell.m
//  iOS
//
//  Created by 颛 清山 on 02/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PlainEditTableViewCell.h"

@implementation PlainEditTableViewCell
@synthesize textField;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [textField setContentVerticalAlignment:UIControlContentHorizontalAlignmentCenter];
        [textField setPlaceholder:@"请输入一个团名"];
        [self.contentView addSubview:textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [textField setFrame:self.bounds];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField1 {
    [textField1 resignFirstResponder];
    return YES;
}


@end
