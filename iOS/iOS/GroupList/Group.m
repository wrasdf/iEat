//
//  Group.m
//  iOS
//
//  Created by 颛 清山 on 02/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Group.h"
#import "Restaurant.h"


@class Restaurant;

@implementation Group
{
    @private
    NSString *name;
    NSString *id;
    NSString *owner;
    NSString *description;
    Restaurant* restaurant;
    NSString *dueDate;
}
@synthesize name;
@synthesize owner;
@synthesize description;
@synthesize restaurant;
@synthesize id;
@synthesize dueDate;

- (id)init {
    self = [super init];
    if (self) {
       restaurant = [[Restaurant alloc] init];
    }

    return self;
}


@end
