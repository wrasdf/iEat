//
//  GroupOwnerOrderController.m
//  iOS
//
//  Created by 颛 清山 on 03/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupOwnerOrderController.h"
#import "GroupDataDelegate.h"
#import "User.h"

@interface GroupOwnerOrderController ()
{
    NSArray *myDishes;
}
@end

@implementation GroupOwnerOrderController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的订餐" image:[UIImage imageNamed:@"user.png"] tag:3];
        [self setTabBarItem:tabBarItem];
        myDishes = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *groupInfo = [[self delegate] GetGroupInfo];
    NSArray * dishes = groupInfo[@"orders"];
    User *user = [User CurrentUser];
    NSArray *myOrders = [dishes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.user.name == %@", user.name]];
    if([myOrders count] != 0){
        myDishes = myOrders[0][@"order_dishes"];
    }


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
    return @"我的订餐";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myDishes count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    if ([myDishes count] == 0){
        cell.textLabel.text = @"当前您没有订餐";
        return cell;
    }
    if ([myDishes count] == indexPath.row){
        cell.textLabel.text = @"总计";
        int total  = 0;
        for (id dish in myDishes) {
            total += [dish[@"price"] integerValue] * [dish[@"quantity"] integerValue];
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d ￥", total];
        return cell;
    }
    NSDictionary * dish = [myDishes objectAtIndex:indexPath.row];
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
