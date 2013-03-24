//
//  GroupDetailsViewController.m
//  iOS
//
//  Created by 颛 清山 on 03/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import "RestaurantDishesViewController.h"
#import "GroupTabBarController.h"
#import "GroupDataDelegate.h"

@interface GroupDetailsViewController ()
{
    enum {
        SectionGroupDesc = 0,
        SectionRestDesc,
        SectionCount
    };
    NSArray *sections;
    NSArray *restDesc;
    NSArray *restDescVals;
    NSArray *groupDesc;
    NSArray *groupDescVals;
    NSDictionary *group;
}
@end

@implementation GroupDetailsViewController
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        sections = @[@"饭团信息", @"餐馆简介"];
        restDesc = @[@"饭店名称", @"订餐电话", @"饭店地址"];
        groupDesc = @[@"团名", @"团长"];
        [self setTitle:@"本团信息"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self tableView] setTableFooterView:[self CreateFooterVIew]];

    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"本团信息" image:[UIImage imageNamed:@"heart.png"] tag:1];
    [self setTabBarItem:tabBarItem];

    group = [[self delegate] GetGroupInfo];
    groupDescVals = [[NSArray alloc] initWithObjects:group[@"name"],  group[@"owner"][@"name"], nil];
    restDescVals = [[NSArray alloc] initWithObjects:group[@"restaurant"][@"name"],group[@"restaurant"][@"telephone"],group[@"restaurant"][@"address"], nil];

}

- (UIView *)CreateFooterVIew {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"买饭去" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(10, 0, 300, 40)];
    [button addTarget:self action:@selector(gotoOrderFood:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [view sizeToFit];
    return view;
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
    return 40;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }

    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)path {
    [[cell textLabel] setTextAlignment:NSTextAlignmentLeft];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell.detailTextLabel setTextColor:[UIColor grayColor]];

//    [cell.textLabel setFont:[UIFont systemFontOfSize:12.0]];
//    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12.0]];


    if (path.section == SectionRestDesc)
   {
       cell.textLabel.text = [restDesc objectAtIndex:path.row];
       cell.detailTextLabel.text = [restDescVals objectAtIndex:path.row];
   }
   else if (path.section == SectionGroupDesc){
       cell.textLabel.text = [groupDesc objectAtIndex:path.row];
       cell.detailTextLabel.text = [groupDescVals objectAtIndex:path.row];
    }
}

@end
