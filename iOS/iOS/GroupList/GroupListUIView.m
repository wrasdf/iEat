//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupListUIView.h"


@implementation GroupListUIView {
    UITableView *groupListTable;
}

- (id)initWithDelegate:(GroupListTableViewLogic *)groupTableLogic andFrame:(CGRect)frame{
    self = [super init];
    if(self){
        groupListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 49) style:UITableViewStyleGrouped];
        groupListTable.backgroundView = nil;
        groupListTable.backgroundColor = [UIColor clearColor];
        self.groupTableLogic = groupTableLogic;
        groupListTable.delegate = self.groupTableLogic;
        groupListTable.dataSource = self.groupTableLogic;
        [self setFrame:frame];
        [self addSubview: groupListTable];
    }
    return self;
}

@end