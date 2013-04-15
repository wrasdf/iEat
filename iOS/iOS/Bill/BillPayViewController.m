//
//  BillPayViewController.m
//  iOS
//
//  Created by 颛 清山 on 04/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BillPayViewController.h"
#import "BillDataService.h"
#import "BillDataDelegate.h"

@interface BillPayViewController ()
{
    NSArray *orders;
    UIButton *noDebt;
}
@end

@implementation BillPayViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"交团费" image:[UIImage imageNamed:@"arrow_up.png"] tag:2];
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
    orders = [billsInfo objectForKey:@"payback_orders"];
    [self.tableView reloadData];
    [self.tableView.tableFooterView setHidden:[orders count] != 0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFooter];
}

- (void)addFooter {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    noDebt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [noDebt setFrame:CGRectMake(10, 10, 300, 40)];
    [noDebt setTitle:@"没有欠款哦" forState:UIControlStateNormal];
    [noDebt setEnabled:NO];
    [view addSubview:noDebt];
    self.tableView.tableFooterView = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id order = [orders objectAtIndex:section];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button setTitle:@"删除" forState:UIControlStateNormal];
//    [button setFrame:CGRectMake(270, 10, 40, 30)];
//    [button setTag:[[order objectForKey:@"id"] integerValue]];
//    [button addTarget:self action:@selector(moneyGoHome:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];

    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];

    NSString *username = [[[order objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"name"];
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
    UITableViewCell *cell = [self dishCell];

    NSArray * dishes = [[orders objectAtIndex:indexPath.section] objectForKey:@"order_dishes"];
    if ([dishes count] == indexPath.row) {
        UITableViewCell *summaryCell = [self summaryCell];
        float total = 0;
        for (id dish in dishes) {
            total += [dish[@"price"] floatValue] * [dish[@"quantity"] integerValue];
        }
        summaryCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f ￥", total];
        return summaryCell;
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
