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

@implementation GroupTabBarController  {
    NSDictionary *groupInfo;
}


- (id)initWithGroup:(NSDictionary *)group {
    self = [super init];
    if (self != nil){
        groupInfo = group;
        GroupDetailsViewController* groupDetailsViewController = [[GroupDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        GroupStatsController* groupStatController = [[GroupStatsController alloc] initWithStyle:UITableViewStyleGrouped];
        GroupOwnerOrderController* groupOwnersDishesController = [[GroupOwnerOrderController alloc] initWithStyle:UITableViewStyleGrouped];
        GroupMemberOrdersController* groupMemberDishesController = [[GroupMemberOrdersController alloc] initWithStyle:UITableViewStyleGrouped];
        groupDetailsViewController.delegate = self;
//        groupStatController.delegate = self;
        groupOwnersDishesController.delegate = self;
        groupMemberDishesController.delegate = self;
        self.viewControllers = @[groupDetailsViewController,groupStatController, groupOwnersDishesController, groupMemberDishesController];
        [self setSelectedIndex:0];
    }
    return self;
}

- (NSDictionary *)GetGroupInfo {
    return groupInfo;
}

@end
