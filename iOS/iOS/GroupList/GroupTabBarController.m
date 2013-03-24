//
//  GroupTabBarController.m
//  iOS
//
//  Created by 颛 清山 on 03/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupTabBarController.h"
#import "GroupMemberOrdersController.h"
#import "GroupOwnerOrderController.h"
#import "GroupStatsController.h"
#import "GroupDetailsViewController.h"

@implementation GroupTabBarController

- (id)initWithGroup:(NSDictionary *)group {
    self = [super init];
    if (self != nil){
        id groupDetailsViewController = [[GroupDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        id groupStatController = [[GroupStatsController alloc] initWithStyle:UITableViewStyleGrouped];
        id groupOwnersDishesController = [[GroupOwnerOrderController alloc] initWithStyle:UITableViewStyleGrouped];
        id groupMemberDishesController = [[GroupMemberOrdersController alloc] initWithStyle:UITableViewStyleGrouped];
        self.viewControllers = @[groupDetailsViewController,groupStatController, groupOwnersDishesController, groupMemberDishesController];
        [self setSelectedIndex:0];
    }
    return self;
}
@end
