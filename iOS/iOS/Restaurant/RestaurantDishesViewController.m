//
//  RestaurantDishesViewController.m
//  iOS
//
//  Created by 颛 清山 on 03/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RestaurantDishesViewController.h"
#import "GroupDataService.h"
#import "OrderCellAccessory.h"

@interface RestaurantDishesViewController ()
{
    NSArray *dishes;
}
@end

@implementation RestaurantDishesViewController

- (id)initWithGroupId:(int)groupId {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        dishes = [GroupDataService GetGroupDishes:groupId];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CreateSearchBar];

}

- (void)CreateSearchBar {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];

    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
    [searchBar setShowsCancelButton:YES animated:YES];
    [searchBar setPlaceholder:@"输入要查询的菜名"];
    [searchBar sizeToFit];
    [header addSubview:searchBar];
    [[self tableView] setTableHeaderView:header];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dishes count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [dishes objectAtIndex:section][@"name"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dishes objectAtIndex:section][@"dishes"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)path {
    NSArray * typeDishes = [dishes objectAtIndex:path.section][@"dishes"];
    cell.textLabel.text = [typeDishes objectAtIndex:path.row][@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ￥", [typeDishes objectAtIndex:path.row][@"price"]];
    [cell setAccessoryView:[[OrderCellAccessory alloc] initWithIndexPath:path]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    OrderCellAccessory *accessory = [cell accessoryView];
    [accessory increaseQuantity];
}

@end
