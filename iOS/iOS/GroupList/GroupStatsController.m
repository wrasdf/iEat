//
//  GroupStatsController.m
//  iOS
//
//  Created by 颛 清山 on 03/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupStatsController.h"
#import "GroupDataDelegate.h"
#import "User.h"

@interface GroupStatsController ()
{
    NSMutableDictionary *dishesDict;
    NSArray *allKeys;
    NSArray *allValues;
    NSString *tel;
}

@end

@implementation GroupStatsController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"统计信息" image:[UIImage imageNamed:@"bar-chart.png"] tag:2];
        [self setTabBarItem:tabBarItem];
        dishesDict  = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    [[self tableView] setTableFooterView:[self CreateFooterView]];
}

- (void)viewWillAppear:(BOOL)animated {
    NSDictionary *groupInfo = [[self delegate] GetGroupInfo];
    tel = groupInfo[@"restaurant"][@"telephone"];
    NSArray * orders = groupInfo[@"orders"];
    [dishesDict removeAllObjects];
    for (NSDictionary * order in orders){
        NSArray * dishes = order[@"order_dishes"];
        for (NSDictionary *dish in dishes){
            NSLog([NSString stringWithFormat:@"%@ %@ %@", dish[@"name"], dish[@"price"], dish[@"quantity"]]);
            NSMutableDictionary * dict = [dishesDict objectForKey:dish[@"name"]];
            if (dict){
                unsigned long quantity = [dict[@"quantity"] integerValue] + [dish[@"quantity"] integerValue];
                [dict setValue:[NSNumber numberWithInt:quantity] forKey:@"quantity"];
            }
            else{
                NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dish[@"quantity"], @"quantity", dish[@"price"], @"price", nil];
                [dishesDict setObject:tmp forKey:dish[@"name"]];
            }
        }
    }
    allKeys = [dishesDict allKeys];
    allValues = [dishesDict allValues];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


- (UIView *)CreateFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setImage:[UIImage imageNamed:@"phone.png"] forState:UIControlStateNormal];
    [button setTitle:@" 打电话" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(10, 0, 300, 40)];
    [button addTarget:self action:@selector(callRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
- (BOOL)isNumericString:(NSString *)inputString {
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    return [alphaNums isSupersetOfSet:characterSet];
}
- (void)callRestaurant:(id)callRestaurant {
    if (![self isNumericString:tel]) {
        [[[UIAlertView alloc] initWithTitle:@"失败" message:@"餐馆电话未提供或不正确" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
        return;
    }
    NSString *theCall = [NSString stringWithFormat:@"tel://%@",tel];
    NSLog(@"making call with %@",theCall);
#if !(TARGET_IPHONE_SIMULATOR)
    UIApplication *myApp = [UIApplication sharedApplication];
    [myApp openURL:[NSURL URLWithString:theCall]];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"统计信息";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dishesDict count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self dishCell];

    if ([dishesDict count] == 0){
        cell.textLabel.text = @"当前没有订餐";
        return cell;
    }
    if (indexPath.row == [dishesDict count]) {
        UITableViewCell *summaryCell = [self summaryCell];
        float total  = 0;
        for (id dish in allValues) {
           total += [dish[@"price"] floatValue] * [dish[@"quantity"] integerValue];
        }
        summaryCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f ￥", total];
        return summaryCell;
    }
    cell.textLabel.text = [allKeys objectAtIndex:(NSUInteger)indexPath.row];
    NSString *price = [NSString stringWithFormat:@"%@ ￥", [allValues objectAtIndex:indexPath.row][@"price"]];
    cell.detailTextLabel.text = price;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSString *quantity = [NSString stringWithFormat:@"%@", [allValues objectAtIndex:indexPath.row][@"quantity"]];

    [button setTitle:quantity forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 10, 25, 25)];
    [cell setAccessoryView:button];

    return cell;
}


-(UITableViewCell*)summaryCell {
    static NSString *SummaryCellIdentifier = @"SummaryCell";
    UITableViewCell *summaryCell = [[self tableView] dequeueReusableCellWithIdentifier:SummaryCellIdentifier];
    if (summaryCell == nil){
        summaryCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SummaryCellIdentifier];
    }
    summaryCell.textLabel.text = @"总计";
    return summaryCell;
}


-(UITableViewCell*)dishCell {
    static NSString *dishCellIdentifier = @"DishCell";
    UITableViewCell *dishCell = [[self tableView] dequeueReusableCellWithIdentifier:dishCellIdentifier];
    if (dishCell == nil){
        dishCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dishCellIdentifier];
    }
    dishCell.textLabel.numberOfLines = 1;
    [dishCell.textLabel setAdjustsFontSizeToFitWidth:YES];
    return dishCell;
}


@end
