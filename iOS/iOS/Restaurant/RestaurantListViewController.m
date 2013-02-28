//
//  RestaurantListViewController.m
//  iOS
//
//  Created by 颛 清山 on 02/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "GroupDetailViewController.h"

@interface RestaurantListViewController ()

@end

@implementation RestaurantListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView setRowHeight:100];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.text = @"肯德基宅急送";
        cell.detailTextLabel.text = @"电话：4008823823.\n 送餐可能需1~2小时，下单请谨慎！ / 送餐费 8元";
        [cell.detailTextLabel setAdjustsFontSizeToFitWidth:NO];
        cell.detailTextLabel.numberOfLines=0;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *restName = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    GroupDetailViewController *groupDetailViewController = (GroupDetailViewController *) [self presentingViewController];
    [groupDetailViewController setRestName:restName];
    [[groupDetailViewController tableView] reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
