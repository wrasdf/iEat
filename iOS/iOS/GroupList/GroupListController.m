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
#import "GroupStatsController.h"
#import "GroupOwnerOrderController.h"
#import "GroupMemberOrdersController.h"

@implementation GroupListController {
    NSArray *groups;
    NSMutableArray *myGroups;
    NSMutableArray *otherGroups;
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
    groups = [GroupDataService groupListOfToday];
    User *user = [User CurrentUser];
    for (NSDictionary * group in groups){
      if (group[@"joined"] == @"1")   {
          [myGroups addObject:group];
      }
      else if (((NSDictionary *) (group[@"owner"]))[@"name"] == user.name){
          [myGroups addObject:group];
      }
      else{
          [otherGroups addObject:group];
      }
        
    }
    myGroups = [groups filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.owner.name == %@", user.name]];
    otherGroups = [groups filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.owner.name != %@", user.name]];
    [self.tableView reloadData];
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

    NSString *cellIdentifier = @"GroupSummaryCell";

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
    GroupDetailsViewController * groupDetailsViewController;
    if (indexPath.section == SectionMyGroup){

    } else if (indexPath.section == SectionAvailableGroup){
    }

    UITabBarController* groupsTabController = [[UITabBarController alloc]init];

    groupDetailsViewController = [[GroupDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    id groupStatController = [[GroupStatsController alloc] initWithStyle:UITableViewStyleGrouped];
    id groupOwnersDishesController = [[GroupOwnerOrderController alloc] initWithStyle:UITableViewStyleGrouped];
    id groupMemberDishesController = [[GroupMemberOrdersController alloc] initWithStyle:UITableViewStyleGrouped];

    groupsTabController.viewControllers = @[groupDetailsViewController,groupStatController, groupOwnersDishesController, groupMemberDishesController];
    [groupsTabController setSelectedIndex:0];
    [[self navigationController] pushViewController:groupsTabController animated:YES];
}

- (void)configureCell:(GroupSummaryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    UIImage *image = [UIImage imageNamed:@"coffee.png" ];
    [cell.imageView setImage:image];
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