//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupListUIView.h"
#import "GroupListTableViewLogic.h"
#import "CreateUIElement.h"


@implementation GroupListUIView {
    UITableView *groupListTable;
    GroupListTableViewLogic *tableLogic;
    UIButton *createGroupBtn;
}

- (id)initWithDelegate:(GroupListTableViewLogic *)groupTableLogic andFrame:(CGRect)frame{
    self = [super init];
    if(self){
        tableLogic =  groupTableLogic;
        [self setFrame:frame];
        [self createUI];

    }
    return self;
}

-(void) createUI{
    [self addCreateButton];
    [self createListTable];
}

-(void) addCreateButton{
    createGroupBtn = [[CreateUIElement alloc] createButtonWithCGRect:CGRectMake(10, 10, 300, 40) andWithTitle:@"+ Create My Group"];
    [createGroupBtn addTarget:_delegate action:@selector(createPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:createGroupBtn];
}

-(void) createListTable{
    groupListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, [UIScreen mainScreen].bounds.size.height - 49) style:UITableViewStyleGrouped];
    groupListTable.backgroundView = nil;
    groupListTable.backgroundColor = [UIColor clearColor];
    self.groupTableLogic = tableLogic;
    groupListTable.delegate = self.groupTableLogic;
    groupListTable.dataSource = self.groupTableLogic;
    [self addSubview: groupListTable];
}


@end