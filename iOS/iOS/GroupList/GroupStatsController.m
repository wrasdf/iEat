//
//  GroupStatsController.m
//  iOS
//
//  Created by 颛 清山 on 03/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GroupStatsController.h"

@interface GroupStatsController ()
{
    NSArray *dishes;
}
@end

@implementation GroupStatsController
//@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"统计信息" image:[UIImage imageNamed:@"bar-chart.png"] tag:2];
        [self setTabBarItem:tabBarItem];

        dishes = @[@"小炒肉 12￥", @"小笼包 30￥"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setImage:[UIImage imageNamed:@"phone.png"] forState:UIControlStateNormal];
    [button setTitle:@" 打电话" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(10, 0, 300, 40)];
    [button addTarget:self action:@selector(callRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    [[self tableView] setTableFooterView:view];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dishes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [dishes objectAtIndex:indexPath.row];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"3" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 10, 30, 30)];
    [cell setAccessoryView:button];

    return cell;
}


@end
