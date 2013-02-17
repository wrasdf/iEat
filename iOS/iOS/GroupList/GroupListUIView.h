//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class GroupListTableViewLogic;
@class CreateUIElement;

@interface GroupListUIView : UIView
- (id)initWithDelegate:(GroupListTableViewLogic *)groupTableLogic andFrame:(CGRect)frame;
@property (nonatomic, strong) id groupTableLogic;
@property (nonatomic, strong) id delegate;
@end