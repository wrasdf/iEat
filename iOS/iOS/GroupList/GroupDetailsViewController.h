//
//  GroupDetailsViewController.h
//  iOS
//
//  Created by 颛 清山 on 03/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@protocol GroupDataDelegate;

@interface GroupDetailsViewController : UITableViewController {
}
@property(nonatomic, strong) NSObject <GroupDataDelegate> *delegate;

@end
