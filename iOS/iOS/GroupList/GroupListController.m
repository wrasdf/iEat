//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupListController.h"
#import "User.h"
#import "GroupSummaryViewCell.h"
#import "GroupDataService.h"
#import "GroupAddViewController.h"
#import "GroupDetailsViewController.h"

@implementation GroupListController {
    NSArray *groups;
    NSArray *myGroups;
    NSArray *otherGroups;
    enum{
        SectionMyGroup = 0,
        SectionAvailableGroup,
        SectionCount
    };
}


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [[self tableView] setRowHeight:56];
        [self setTitle:@"饭团列表"];
    }
    return self;
}
- (void)GetGroupList {
    groups = [GroupDataService groupListOfToday][@"active_groups"];
    User *user = [User CurrentUser];
    myGroups = [groups filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.owner.name == %@", user.name]];
    otherGroups = [groups filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.owner.name != %@", user.name]];
}


- (IBAction) add:(id) sender {
    GroupAddViewController *groupDetailViewController = [[GroupAddViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [[self navigationController] pushViewController:groupDetailViewController animated:YES];
}

-(void) createBarButtonOnNavigationBar{

    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(Logout:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)Logout:(id)Logout {
    [User SetCurrentUserName:nil email: nil token:nil];
    [(UINavigationController *) [self parentViewController] popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self GetGroupList];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarButtonOnNavigationBar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == SectionMyGroup){
        return [myGroups count];
    }
    else if(section == SectionAvailableGroup){
        return [otherGroups count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == SectionMyGroup){
        return @"我的饭团";
    }
    else if (section == SectionAvailableGroup){
        return @"其他饭团";
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SectionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Identifier for retrieving reusable cells. static NSString
    NSString *cellIdentifier = @"GroupSummaryCell"; // Attempt to request the reusable cell.

    GroupSummaryViewCell *cell = (GroupSummaryViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[GroupSummaryViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == SectionMyGroup;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Deleted");
        [GroupDataService removeGroup:myGroups[indexPath.row][@"_id"]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *message;
    GroupDetailsViewController * groupDetailsViewController;
    if (indexPath.section == SectionMyGroup){

    } else if (indexPath.section == SectionAvailableGroup){
    }

    UITabBarController* groupsTabController = [[UITabBarController alloc]init];

    groupDetailsViewController = [[GroupDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [groupDetailsViewController setTitle:@"本团信息"];

    UITableViewController *groupStatController = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [groupStatController setTitle:@"统计信息"];

    UITableViewController *groupOwnersDishesController = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [groupOwnersDishesController setTitle:@"我的订餐"];

    UITableViewController *groupMemberDishesController = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [groupMemberDishesController setTitle:@"团员信息"];

    groupsTabController.viewControllers = @[groupDetailsViewController,groupStatController, groupOwnersDishesController, groupMemberDishesController];
    [[self navigationController] pushViewController:groupsTabController animated:YES];
}

- (void)configureCell:(GroupSummaryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    [cell.imageView setImage:[UIImage imageNamed:@"fork.png"] ];
    NSDictionary * group;
    if (indexPath.section == SectionMyGroup){
        group = myGroups[indexPath.row];

    } else if (indexPath.section == SectionAvailableGroup){
        group = otherGroups[indexPath.row];
    }

    cell.restaurantNameLabel.text = group[@"restaurant"][@"name"];
    cell.groupNameLabel.text = group[@"name"];
    cell.dueDateLabel.text = [@"截止日期: " stringByAppendingString: group[@"due_date"]];
    cell.ownerLabel.text = group[@"owner"][@"name"];
}

@end