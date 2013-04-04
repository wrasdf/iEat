//
//  GroupMemberOrdersController.m
//  iOS
//
//  Created by 颛 清山 on 03/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupMemberOrdersController.h"
#import "GroupDataDelegate.h"
#import "User.h"

@interface GroupMemberOrdersController ()
{
    NSArray *orders;

}
@end

@implementation GroupMemberOrdersController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"团员信息" image:[UIImage imageNamed:@"group.png"] tag:4];
        [self setTabBarItem:tabBarItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    }

- (void)viewWillAppear:(BOOL)animated {
    NSDictionary *groupInfo = [[self delegate] GetGroupInfo];
    NSArray * dishes = groupInfo[@"orders"];
    User *user = [User CurrentUser];
    orders = [dishes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.user.name != %@", user.name]];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([orders count] != 0)
        return [orders objectAtIndex:section][@"user"][@"name"];
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUInteger ordersCount = [orders count];
    if (ordersCount == 0) return 1;
    return ordersCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([orders count] == 0){
        return 1;
    }
    return [[orders objectAtIndex:section][@"order_dishes"] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if ([orders count] == 0){
        cell.textLabel.text = @"当前没有其他人没有订餐";
        return cell;
    }
    NSDictionary * order = [orders objectAtIndex:indexPath.section];
    NSArray * dishes = order[@"order_dishes"];
    if ([dishes count] == indexPath.row){
        cell.textLabel.text = @"总计";
        int total  = 0;
        for (id dish in dishes) {
            NSLog([NSString stringWithFormat:@"%@ %@ %@", dish[@"name"], dish[@"price"], dish[@"quantity"]]);
            total += [dish[@"price"] integerValue] * [dish[@"quantity"] integerValue];
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d ￥", total];
        return cell;
    }
    
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

@end
