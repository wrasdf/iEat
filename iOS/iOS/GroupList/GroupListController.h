//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class GroupDetailsViewController;

@interface GroupListController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
- (void)ShowGroupDetails:(id)groupId;

@end