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

    NSDictionary *groupInfo = [[self delegate] GetGroupInfo];
    NSArray * orders = groupInfo[@"orders"];
    for (NSDictionary * order in orders){
        NSArray * dishes = order[@"order_dishes"];
        for (NSDictionary *dish in dishes){
            NSLog([NSString stringWithFormat:@"%@ %@ %@", dish[@"name"], dish[@"price"], dish[@"quantityBtn"]]);
            NSMutableDictionary * dict = [dishesDict objectForKey:dish[@"name"]];
            if (dict){
                unsigned long quantity = [dict[@"quantityBtn"] integerValue] + [dish[@"quantityBtn"] integerValue];
                [dict setValue:[NSNumber numberWithInt:quantity] forKey:@"quantityBtn"];
            }
            else{
                NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dish[@"quantityBtn"], @"quantityBtn", dish[@"price"], @"price", nil];
                [dishesDict setObject:tmp forKey:dish[@"name"]];
            }
        }
    }
    allKeys = [dishesDict allKeys];
    allValues = [dishesDict allValues];

    [[self tableView] setTableFooterView:[self CreateFooterView]];
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

- (void)callRestaurant:(id)callRestaurant {
    NSString *theCall = [NSString stringWithFormat:@"tel://%@",@"13426049524"];
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if ([dishesDict count] == 0){
        cell.textLabel.text = @"当前没有订餐";
        return cell;
    }
    if (indexPath.row == [dishesDict count]) {
        cell.textLabel.text = @"总计";
        int total  = 0;
        for (id dish in allValues) {
           total += [dish[@"price"] integerValue] * [dish[@"quantityBtn"] integerValue];
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d ￥", total];
        return cell;
    }
    cell.textLabel.text = [allKeys objectAtIndex:(NSUInteger)indexPath.row];
    NSString *price = [NSString stringWithFormat:@"%@ ￥", [allValues objectAtIndex:indexPath.row][@"price"]];
    cell.detailTextLabel.text = price;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSString *quantity = [NSString stringWithFormat:@"%@", [allValues objectAtIndex:indexPath.row][@"quantityBtn"]];

    [button setTitle:quantity forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 10, 25, 25)];
    [cell setAccessoryView:button];

    return cell;
}


@end
