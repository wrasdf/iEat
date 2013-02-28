//
//  Group.h
//  iOS
//
//  Created by 颛 清山 on 02/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

@class Restaurant;

@interface Group : NSObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *owner;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, strong) Restaurant *restaurant;
@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *dueDate;


@end
