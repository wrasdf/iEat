//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface GroupListController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *otherItems;
@property (nonatomic,strong) NSArray *myItems;
@end