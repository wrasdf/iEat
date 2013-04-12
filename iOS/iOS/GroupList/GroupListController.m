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
#import "GroupMyOrderController.h"
#import "GroupMemberOrdersController.h"
#import "GroupTabBarController.h"
#import "BillTabBarController.h"

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
        [self setTitle:@"饭团列表"];
        myGroups = [[NSMutableArray alloc] init];
        otherGroups = [[NSMutableArray alloc] init];
        [[self tableView] setRowHeight:60];
    }
    return self;
}
- (void)GetGroupList {
    groups = [GroupDataService groupListOfToday];
    [myGroups removeAllObjects];
    [otherGroups removeAllObjects];
    User *user = [User CurrentUser];
    for (NSDictionary * group in groups){
      if ([group[@"joined"] boolValue])   {
          [myGroups addObject:group];
      }
      else if ([group[@"owner"][@"name"] isEqual:user.name] ){
          [myGroups addObject:group];
      }
      else{
          [otherGroups addObject:group];
      }
    }
    [self.tableView reloadData];
}


- (IBAction) add:(id) sender {
    GroupAddViewController *addGroup;

    addGroup = [[GroupAddViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [addGroup SetGroupListController:self];
    [[self navigationController] pushViewController:addGroup animated:YES];
}

-(void) createBarButtonOnNavigationBar{

    UIBarButtonItem *billBtn = [[UIBarButtonItem alloc] initWithTitle:@"账单" style:UIBarButtonItemStylePlain target:self action:@selector(myBills:)];
    self.navigationItem.rightBarButtonItem = billBtn;

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(Logout:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)myBills:(id)myBills {
    BillTabBarController* billTabController = [[BillTabBarController alloc] init];

    [billTabController setSelectedIndex:0];
    [[self navigationController] pushViewController:billTabController animated:YES];
}

- (void)Logout:(id)Logout {
    [User SetCurrentUserName:nil email: nil token:nil];
    [(UINavigationController *) [self parentViewController] popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self GetGroupList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarButtonOnNavigationBar];
    self.tableView.tableHeaderView = [self CreateHeaderView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == SectionMyGroup){
        NSUInteger myGrouCount = [myGroups count];
        return myGrouCount  == 0 ? 1 : myGrouCount;
    }
    else if(section == SectionAvailableGroup){
        NSUInteger count = [otherGroups count];
        return count == 0 ? 1 : count;
    }
    return 0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (section == SectionMyGroup && [myGroups count] == 0) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 340, 40)];
//        label.text = @"  没有与您相关的团";
//        return label;
//    } else if (section == SectionAvailableGroup && [otherGroups count] == 0){
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 340, 40)];
//        label.text = @"  现在暂时没有其他可加入的团";
//        return label;
//    }
//    return nil;//[super tableView:tableView viewForFooterInSection:section];
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == SectionMyGroup){
        return @"我的饭团";
    }
    else if (section == SectionAvailableGroup){
        return @"其他饭团";
    }
    return nil;
}


- (UIView *)CreateHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"创建我的饭团" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 320, 40)];
    [button addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SectionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == SectionMyGroup) && ([myGroups count] == 0)){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyCell"];
        cell.textLabel.text = @"没有与您相关的团";
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0] ];
        return cell;
    }
    if ((indexPath.section == SectionAvailableGroup) && ([otherGroups count] == 0)){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyCell"];
        cell.textLabel.text = @"现在暂时没有其他可加入的团";
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0] ];

        return cell;
    }

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
    if (indexPath.section == SectionMyGroup && [myGroups count]== 0) {
        return;
    }else if (indexPath.section == SectionAvailableGroup && [otherGroups count] == 0){
        return;
    }

    id group;
    if (indexPath.section == SectionMyGroup){
        group = [myGroups objectAtIndex:indexPath.row];
    } else if (indexPath.section == SectionAvailableGroup){
        group = [otherGroups objectAtIndex:indexPath.row];
    }
    id groupId = group[@"id"];
    

    [self ShowGroupDetails:groupId];

}

- (void)ShowGroupDetails:(id)groupId {
    GroupTabBarController* groupsTabController = [[GroupTabBarController alloc] initWithGroupId:groupId];

    [groupsTabController setSelectedIndex:0];
    [[self navigationController] pushViewController:groupsTabController animated:YES];
}

- (void)configureCell:(GroupSummaryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    UIImage *image = [UIImage imageNamed:@"coffee.png" ];
    UIImage *created = [UIImage imageNamed:@"created.png" ];
    UIImage *joined = [UIImage imageNamed:@"joined.png" ];
    NSDictionary * group;
    User *user = [User CurrentUser];
    if (indexPath.section == SectionMyGroup){
        group = myGroups[indexPath.row];
        if([group[@"owner"][@"name"] isEqual:user.name]){
            [cell.imageView setImage:created];
        }else{
            [cell.imageView setImage:joined];
        }

    } else if (indexPath.section == SectionAvailableGroup){
        group = otherGroups[indexPath.row];
        [cell.imageView setImage:image];

    }

    cell.restaurantNameLabel.text = group[@"restaurant"][@"name"];
    cell.groupNameLabel.text = group[@"name"];
    cell.dueDateLabel.text = [@"截止日期: " stringByAppendingString: group[@"due_date"]];
    cell.ownerLabel.text = group[@"owner"][@"name"];
}



@end