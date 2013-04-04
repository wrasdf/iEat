//
//  BillGatherViewController.m
//  iOS
//
//  Created by 颛 清山 on 04/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BillGatherViewController.h"
#import "BillDataDelegate.h"
#import "BillDataService.h"


@interface BillGatherViewController ()
{
  NSArray *orders;
  UIButton *payOffBtn;
}
@end

@implementation BillGatherViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收团费" image:[UIImage imageNamed:@"arrow_down.png"] tag:1];
        [self setTabBarItem:tabBarItem];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self ReDrawData];
}

- (void)ReDrawData {
    NSDictionary *billsInfo = [self.delegate getBillsInfo];
    orders = [billsInfo objectForKey:@"unpaid_orders"];
    [self.tableView reloadData];
    if ([orders count] == 0){
        [payOffBtn setEnabled:NO];
        [payOffBtn setTitle:@"没有欠款哦" forState:UIControlStateNormal];
    }
    else{
        [payOffBtn setEnabled:YES];
        [payOffBtn setTitle:@"提醒还钱" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addFooter];
}

- (void)addFooter {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    payOffBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [payOffBtn setFrame:CGRectMake(10, 10, 300, 40)];
    [payOffBtn addTarget:self action:@selector(sendReminder:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:payOffBtn];
    self.tableView.tableFooterView = view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id order = [orders objectAtIndex:section];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"删除" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(270, 10, 40, 30)];
    [button setTag:[[order objectForKey:@"id"] integerValue]];
    [button addTarget:self action:@selector(moneyGoHome:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    NSString *username = [[(NSDictionary *) order objectForKey:@"user"] objectForKey:@"name"];
    NSString *date = [(NSDictionary *) order objectForKey:@"created_at"] ;
    [sectionTitle setText:[NSString stringWithFormat:@"%@  %@", [date substringToIndex:10], username]];
    [sectionTitle setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [sectionTitle sizeToFit];
    [view addSubview:sectionTitle];
    return view;
}

- (void)moneyGoHome:(UIButton *)sender {
    NSLog([NSString stringWithFormat:@"%d", sender.tag]);
    [BillDataService payOffBill:sender.tag];
    [[self delegate] updateBillsInfo];
    [self ReDrawData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;//[super tableView:tableView heightForHeaderI;nSection:section];
}

- (void)sendReminder:(UIButton *)sender {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [orders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * order = [orders objectAtIndex:section];
    return [[order objectForKey:@"order_dishes"] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BillCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    NSArray * dishes = [[orders objectAtIndex:indexPath.section] objectForKey:@"order_dishes"];
    if ([dishes count] == indexPath.row) {
        cell.textLabel.text = @"总计";
        int total = 0;
        for (id dish in dishes) {
            total += [dish[@"price"] integerValue] * [dish[@"quantity"] integerValue];
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d ￥", total];
    }
    else{
        id dish = [dishes objectAtIndex:indexPath.row];
        cell.textLabel.text = [dish objectForKey:@"name"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@￥ ", [dish objectForKey:@"price"]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:[NSString stringWithFormat:@"%@", dish[@"quantity"]] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 10, 25, 25)];
        [cell setAccessoryView:button];
    }
    
    return cell;
}



@end
