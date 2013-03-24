//
//  RestaurantListViewController.m
//  iOS
//
//  Created by 颛 清山 on 02/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "Restaurant.h"
#import "RestaurantDataService.h"

@interface RestaurantListViewController ()
{
  NSArray *restaurants;
}
@end

@implementation RestaurantListViewController
@synthesize restaurant;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView setRowHeight:70];
        restaurant = [[Restaurant alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self GetRestaurantList];
}

- (void)GetRestaurantList {
    restaurants = [RestaurantDataService restaurantList];
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
    return [restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        NSDictionary *restaurant = [restaurants objectAtIndex:indexPath.row];
        cell.textLabel.text = restaurant[@"name"];
        NSString *info = [NSString stringWithFormat:@"电话：%@.\n地址：%@", restaurant[@"telephone"], restaurant[@"address"]];
        cell.detailTextLabel.text = info;
        [cell.detailTextLabel setAdjustsFontSizeToFitWidth:NO];
        cell.detailTextLabel.numberOfLines=0;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
    NSDictionary *selected = [restaurants objectAtIndex:indexPath.row];
    restaurant.name = selected[@"name"];
    restaurant.id = selected[@"id"];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
