    //
//  GroupMyOrderController.m
//  iOS
//
//  Created by 颛 清山 on 03/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupMyOrderController.h"
#import "GroupDataDelegate.h"
#import "User.h"
#import "BillDataService.h"
#import "GroupDataService.h"

@interface GroupMyOrderController ()
{
    NSMutableArray *myOrders;
    NSDate *dueDate;
    NSDateFormatter *dateFormatter;
}
@end

@implementation GroupMyOrderController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的订餐" image:[UIImage imageNamed:@"user.png"] tag:3];
        [self setTabBarItem:tabBarItem];
        myOrders = [[NSMutableArray alloc] init];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [self redrawData:animated];
}

- (void)redrawData:(BOOL)animated {
    NSDictionary *groupInfo = [[self delegate] GetGroupInfo];
    dueDate = [dateFormatter dateFromString:groupInfo[@"due_date"]];
    NSArray * dishes = groupInfo[@"orders"];
    User *user = [User CurrentUser];
    myOrders = [dishes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.user.name == %@", user.name]];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUInteger ordersCount = [myOrders count];
    if (ordersCount == 0) return 1;
    return ordersCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;//[super tableView:tableView heightForHeaderI;nSection:section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];

    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    [sectionTitle setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [sectionTitle setText:@"我的订餐"];
    [sectionTitle sizeToFit];

    if ([myOrders count]!= 0 && [[NSDate date] compare:dueDate] == NSOrderedAscending){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        [button setFrame:CGRectMake(270, 10, 40, 30)];
        id order = [myOrders objectAtIndex:section];
        [button setTag:[[order objectForKey:@"id"] integerValue]];
        [button addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }

    [view addSubview:sectionTitle];
    return view;
}

- (void)deleteOrder:(UIButton *)sender {
    NSLog([NSString stringWithFormat:@"%d", sender.tag]);
    [GroupDataService DeleteOrder:sender.tag];
    [[self delegate] UpdateGroupInfo];

    [self redrawData:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([myOrders count] == 0){
        return 1;
    }
    return [[myOrders objectAtIndex:section][@"order_dishes"] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self dishCell];
    if ([myOrders count] == 0){
        cell.textLabel.text = @"当前您没有订餐";
        cell.detailTextLabel.text = @"";
        [cell setAccessoryView:nil];
        return cell;
    }
    NSDictionary * order = [myOrders objectAtIndex:indexPath.section];
    NSArray * dishes = order[@"order_dishes"];
    if ([dishes count] == indexPath.row){
        float total  = 0;
        for (id dish in dishes) {
            NSLog([NSString stringWithFormat:@"%@ %@ %@", dish[@"name"], dish[@"price"], dish[@"quantity"]]);
            total += [dish[@"price"] floatValue] * [dish[@"quantity"] integerValue];
        }
        UITableViewCell *summaryCell = [self summaryCell];
        summaryCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f ￥", total];
        return summaryCell;
    }

    [cell sizeToFit];

    NSDictionary *dish = [dishes objectAtIndex:indexPath.row];

    cell.textLabel.text = dish[@"name"];
    NSString *price = [NSString stringWithFormat:@"%@ ￥", dish[@"price"]];
    cell.detailTextLabel.text = price;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:[NSString stringWithFormat:@"%@", dish[@"quantity"]] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 10, 25, 25)];
    [cell setAccessoryView:button];
    return cell;
}

-(UITableViewCell*)summaryCell {
    static NSString *SummaryCellIdentifier = @"SummaryCell";
    UITableViewCell *summaryCell = [[self tableView] dequeueReusableCellWithIdentifier:SummaryCellIdentifier];
    if (summaryCell == nil){
        summaryCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SummaryCellIdentifier];
        summaryCell.textLabel.text = @"总计";
        [summaryCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return summaryCell;
}


-(UITableViewCell*)dishCell {
    static NSString *dishCellIdentifier = @"DishCell";
    UITableViewCell *dishCell = [[self tableView] dequeueReusableCellWithIdentifier:dishCellIdentifier];
    if (dishCell == nil){
        dishCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dishCellIdentifier];
        dishCell.textLabel.numberOfLines = 1;
        [dishCell.textLabel setAdjustsFontSizeToFitWidth:YES];
        [dishCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return dishCell;
}
@end
