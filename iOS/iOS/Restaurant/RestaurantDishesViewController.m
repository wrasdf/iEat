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
}

- (void)AddAccessoryButton:(UITableViewCell *)cell {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"1" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 10, 25, 25)];

    [cell setAccessoryView:button];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView editingStyleForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = [cell accessoryView];
    if (button == nil){
        [self AddAccessoryButton:cell ];
        [self AddSubtractButton:cell ];
    } else{
        NSInteger value = [button.titleLabel.text integerValue];
        value +=1;
        [button setTitle:[NSString stringWithFormat:@"%d", value] forState:UIControlStateNormal];
    }
    [cell setHighlighted:NO];
}

- (void)AddSubtractButton:(UITableViewCell *)cell {
    UIImage *image = [UIImage imageNamed:@"no-entry.png"];
    [cell.imageView setImage:image];
    [cell.imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subtract:)];
    [tap setNumberOfTapsRequired:1];
    [cell.imageView setGestureRecognizers:[NSArray arrayWithObject:tap]];
}

- (void)subtract:(UIImageView *)sender {
    NSLog(@"subtract");
//    NSIndexPath *indexPath = [(UITableView *)[sender superview] indexPathForCell:self];
    NSIndexPath *indexPath =
            [self.tableView
                    indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    NSLog([NSString stringWithFormat:@"%d %d", indexPath.section, indexPath.row]);
}

@end
