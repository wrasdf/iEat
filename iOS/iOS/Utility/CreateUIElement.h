//
// Created by twer on 1/29/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface CreateUIElement : NSObject

-(UILabel *) createLabelWithCGRect:(CGRect) rect andWithTitle:(NSString *) str;
-(UIButton *) createButtonWithCGRect:(CGRect) rect andWithTitle:(NSString *) str;
-(UITextField *) createTextFieldWithCGRect:(CGRect)rect;

@end