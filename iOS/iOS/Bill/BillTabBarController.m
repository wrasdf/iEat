//
//  BillTabBarController.m
//  iOS
//
//  Created by 颛 清山 on 04/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BillTabBarController.h"
#import "BillGatherViewController.h"
#import "BillPayViewController.h"
#import "BillDataService.h"

@implementation BillTabBarController
{
    NSDictionary *billsInfo;

}

- (id)init {
    self = [super init];
    if (self) {
        [self InitTabs];
    }

    return self;
}

- (void)InitTabs {
    BillGatherViewController*billGatherViewController = [[BillGatherViewController alloc] initWithStyle:UITableViewStyleGrouped];
    BillPayViewController*billPayViewController = [[BillPayViewController alloc] initWithStyle:UITableViewStyleGrouped];
    billGatherViewController.delegate = self;
    billPayViewController.delegate = self;
    self.viewControllers = @[billGatherViewController, billPayViewController];
    [self setSelectedIndex:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateBillsInfo];
    [super viewWillAppear:animated];
}

- (void)updateBillsInfo {
    billsInfo = [BillDataService myBills];
}


- (NSDictionary *)getBillsInfo {
    return billsInfo;
}



@end
