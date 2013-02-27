//
//  PlainEditTableViewCell.h
//  iOS
//
//  Created by 颛 清山 on 02/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@interface PlainEditTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    UITextField * textField;

}
@property(nonatomic, strong) UITextField *textField;

@end
