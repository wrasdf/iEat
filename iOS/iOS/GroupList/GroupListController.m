//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupListController.h"
#import "LoginTableViewController.h"
#import "User.h"
#import "GroupSummaryViewCell.h"

@implementation GroupListController {
    LoginTableViewController *logInViewController;
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
        [self setTitle:@"饭团列表"];
    }

    return self;
}


- (IBAction) createPress:(id) sender {

}

- (IBAction)reChargePress:(id) sender {

}

-(void) createBarButtonOnNavigationBar{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Recharge" style:UIBarButtonItemStylePlain target:self action:@selector(reChargePress:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(Logout:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)Logout:(id)Logout {
    [User SetCurrentUserName:nil];
    [self presentViewController:logInViewController animated:YES completion:NULL];
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
    [self addTableViewHeader];
}

- (void)addTableViewHeader {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 10, 300, 50)];
    [button setTitle:@"创建我的饭团" forState:UIControlStateNormal];
    self.tableView.tableHeaderView = button;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == SectionMyGroup){
        return [myItems count];
    }
    else if(section == SectionAvailableGroup){
        return [otherItems count];
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


    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == SectionMyGroup;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSLog(@"Deleted");
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
    cell.dueDateLabel.text = @"截止日期: 2013-02-23 11:00:00";
    cell.ownerLabel.text = @"邹明新";

    if (indexPath.section == SectionMyGroup){
        cell.restaurantNameLabel.text = [self.myItems objectAtIndex:(NSUInteger) indexPath.row];
        cell.groupNameLabel.text = @"iEat小组";//[[self.myItems objectAtIndex:(NSUInteger) indexPath.row] stringByAppendingString:@"-thoughtworks 西宫"];
    } else if (indexPath.section == SectionAvailableGroup){
        cell.restaurantNameLabel.text = [self.otherItems objectAtIndex:(NSUInteger) indexPath.row];
        cell.groupNameLabel.text = @"thoughtworks east wing(test for a very very long name)";//[[self.otherItems objectAtIndex:(NSUInteger) indexPath.row] stringByAppendingString:@" thoughtworks-北京东直门店"];
    }
}

@end