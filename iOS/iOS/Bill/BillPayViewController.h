//
//  BillPayViewController.h
//  iOS
//
//  Created by 颛 清山 on 04/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//


@protocol BillDataDelegate;

@interface BillPayViewController : UITableViewController
@property(nonatomic, strong) NSObject<BillDataDelegate> *delegate;
@end
