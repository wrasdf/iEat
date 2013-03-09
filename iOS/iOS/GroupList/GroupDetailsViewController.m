//
//  GroupDetailsViewController.m
//  iOS
//
//  Created by 颛 清山 on 03/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import "RestaurantDishesViewController.h"

@interface GroupDetailsViewController ()
{
    enum {
        SectionGroupDesc = 0,
        SectionRestDesc,
        SectionCount
    };
    NSArray *sections;
    NSArray *restDesc;
    NSArray *groupDesc;
}
@end

@implementation GroupDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        sections = @[@"饭团信息", @"餐馆简介"];
        restDesc = @[@"饭店名称", @"订餐电话", @"外卖时间", @"起送金额"];
        groupDesc = @[@"团名", @"团长"];
        [self setTitle:@"本团信息"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"买饭去" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(10, 0, 300, 40)];
    [button addTarget:self action:@selector(gotoOrderFood:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view sizeToFit];

    [[self tableView] setTableFooterView:view];

    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"本团信息" image:[UIImage imageNamed:@"heart.png"] tag:1];
    [self setTabBarItem:tabBarItem];
}

- (void)gotoOrderFood:(id)sender {
    NSLog(@"买饭去");
    [[RestaurantDishesViewController alloc]initWithRestaurant:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SectionRestDesc)
        return [restDesc count];
    if (section == SectionGroupDesc)
        return [groupDesc count];
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)path {
   if (path.section == SectionRestDesc)
   {
       cell.textLabel.text = [restDesc objectAtIndex:path.row];
       [cell.textLabel setTextColor:[UIColor grayColor]];
       [cell.textLabel setFont:[UIFont systemFontOfSize:12.0]];
   }
   else if (path.section == SectionGroupDesc){
       cell.textLabel.text = [groupDesc objectAtIndex:path.row];
       [cell.textLabel setTextColor:[UIColor grayColor]];
       [cell.textLabel setFont:[UIFont systemFontOfSize:12.0]];
   }
}

@end
