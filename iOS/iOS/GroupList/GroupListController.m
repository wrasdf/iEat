//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupListController.h"
#import "LoginTableViewController.h"
#import "User.h"
#import "GroupSummaryViewCell.h"
#import "GroupDataService.h"
#import "JSONKit.h"
#import "GroupDetailViewController.h"

@implementation GroupListController {
    LoginTableViewController *logInViewController;
    NSDictionary *groups;
    NSArray *myGroups;
    NSArray *otherGroups;
    enum{
        SectionMyGroup = 0,
        SectionAvailableGroup,
        SectionCount
    };
}
@synthesize otherItems, myItems;


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        logInViewController = [[LoginTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        otherItems = [NSArray arrayWithObjects:@"九头鹰",@"来福士",@"桂林米粉",nil];
        myItems = [NSArray arrayWithObjects:@"咱家饺子",@"粥面故事",@"秦唐府",nil];
        [[self tableView] setRowHeight:56];
//        [self GetGroupList];
        [self setTitle:@"饭团列表"];
    }

    return self;
}

- (void)GetGroupList {
    groups = [GroupDataService groupListOfToday];
    myGroups = [groups objectForKey:@"myGroups"];
    otherGroups = [groups objectForKey:@"groupList"];
}


- (IBAction) add:(id) sender {
    GroupDetailViewController *groupDetailViewController = [[GroupDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [[self navigationController] pushViewController:groupDetailViewController animated:YES];
}

-(void) createBarButtonOnNavigationBar{

    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(Logout:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)Logout:(id)Logout {
    [User SetCurrentUserName:nil];
    [self presentViewController:logInViewController animated:YES completion:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self GetGroupList];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if ([[User CurrentUserName] length] == 0) {
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
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
    if (indexPath.section == SectionMyGroup){
        message = [self.myItems objectAtIndex:(NSUInteger) indexPath.row];
    } else if (indexPath.section == SectionAvailableGroup){
        message = [self.otherItems objectAtIndex:(NSUInteger) indexPath.row];
    }
    [[[UIAlertView alloc] initWithTitle:@"Item Selected" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)configureCell:(GroupSummaryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    [cell.imageView setImage:[UIImage imageNamed:@"fork.png"] ];
    id group;
    if (indexPath.section == SectionMyGroup){
        group = myGroups[indexPath.row];

    } else if (indexPath.section == SectionAvailableGroup){
        group = otherGroups[indexPath.row];
    }

    cell.restaurantNameLabel.text = @"餐馆名字()";
    cell.groupNameLabel.text = group[@"name"];
    cell.dueDateLabel.text = [@"截止日期: " stringByAppendingString: group[@"date"]];
    cell.ownerLabel.text = group[@"owner"];
}

@end