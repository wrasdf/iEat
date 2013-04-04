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
#import "GroupDataService.h"

@implementation GroupTabBarController  {
    NSDictionary *groupInfo;
    id grpId;
}

- (void)InitTabs {
    GroupDetailsViewController* groupDetailsViewController = [[GroupDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    GroupStatsController* groupStatController = [[GroupStatsController alloc] initWithStyle:UITableViewStyleGrouped];
    GroupOwnerOrderController* groupOwnersDishesController = [[GroupOwnerOrderController alloc] initWithStyle:UITableViewStyleGrouped];
    GroupMemberOrdersController* groupMemberDishesController = [[GroupMemberOrdersController alloc] initWithStyle:UITableViewStyleGrouped];
    groupDetailsViewController.delegate = self;
    groupStatController.delegate = self;
    groupOwnersDishesController.delegate = self;
    groupMemberDishesController.delegate = self;
    self.viewControllers = @[groupDetailsViewController,groupStatController, groupOwnersDishesController, groupMemberDishesController];
    [self setSelectedIndex:0];
}

- (id)initWithGroupId:(id)groupId {
    self = [super init];
    if (self) {
        grpId = groupId;
        [self InitTabs];
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self UpdateGroupInfo];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSUInteger i = [self selectedIndex];
    NSLog([NSString stringWithFormat:@"%d", i]);
    [self setSelectedIndex:i];
    [super viewDidAppear:animated];
}

- (void)UpdateGroupInfo {
    groupInfo = [GroupDataService GetGroupById:grpId];
}


- (NSDictionary *)GetGroupInfo {
    return groupInfo;
}

@end
