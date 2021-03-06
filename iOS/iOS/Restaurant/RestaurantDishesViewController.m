//
//  RestaurantDishesViewController.m
//  iOS
//
//  Created by 颛 清山 on 03/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RestaurantDishesViewController.h"
#import "GroupDataService.h"

@interface RestaurantDishesViewController ()
{
    NSArray *dishes;
    NSMutableDictionary *orders;
    int orderGroupId;
    NSDate *dueDate;
}
@end

@implementation RestaurantDishesViewController

- (id)initWithGroupId:(int)groupId dueDate:(NSDate *)date {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        orderGroupId = groupId;
        dueDate = date;
        dishes = [GroupDataService GetGroupDishes:groupId];
        orders = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self CreateSearchBar];
    [self createSubmitButtonOnNavigationBar];

}
-(void)createSubmitButtonOnNavigationBar {

    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(submitOrder:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
}

- (void)submitOrder:(id)sender {

    if ([[NSDate date] compare:dueDate] == NSOrderedDescending){
        [[[UIAlertView alloc] initWithTitle:@"失败" message:@"已过订饭时间" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
        return;
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSString* key in orders){
        NSDictionary *order = [[NSDictionary alloc] initWithObjectsAndKeys:key, @"id", orders[key], @"quantity", nil];
        [array addObject:order];
    }
    [GroupDataService SubmitOrder: array forGroup: orderGroupId];

    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:NO];
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
    UITableViewCell *cell = [self dishCell];
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)path {
    NSArray * typeDishes = [dishes objectAtIndex:path.section][@"dishes"];
    cell.textLabel.text = [typeDishes objectAtIndex:path.row][@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ￥", [typeDishes objectAtIndex:path.row][@"price"]];
    OrderCellAccessory *cellAccessory = [[OrderCellAccessory alloc] initWithIndexPath:path];
    cellAccessory.delegate = self;
    [cell setAccessoryView:cellAccessory];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

}


-(UITableViewCell*)dishCell {
    static NSString *dishCellIdentifier = @"DishCell";
    UITableViewCell *dishCell = [[self tableView] dequeueReusableCellWithIdentifier:dishCellIdentifier];
    if (dishCell == nil){
        dishCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dishCellIdentifier];
        [dishCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        dishCell.textLabel.numberOfLines = 1;
        [dishCell.textLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return dishCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    OrderCellAccessory *accessory = [cell accessoryView];
    [accessory increaseQuantity];
}

- (void)updateQuantityAtIndexPath:(NSIndexPath *)indexPath withQuantity:(int)quantity {
    NSArray * typeDishes = [dishes objectAtIndex:indexPath.section][@"dishes"];
    id key = [typeDishes objectAtIndex:indexPath.row][@"id"];
    NSLog([NSString stringWithFormat:@"%@ %d", key, quantity]);
    if(quantity == 0)
        [orders removeObjectForKey:key];
    else
        [orders setObject:[NSNumber numberWithInt:quantity] forKey:key];
}

@end
