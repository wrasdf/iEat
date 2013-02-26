//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class GroupSummaryViewCell;

@protocol GroupListProtocol;

@interface GroupListTableViewLogic : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *otherItems;
@property (nonatomic,strong) NSArray *myItems;
@property (nonatomic,strong) id<GroupListProtocol> delegate;

- (void)configureCell:(GroupSummaryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end