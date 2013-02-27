//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupListController.h"
#import "GroupListUIView.h"
#import "GroupListTableViewLogic.h"
#import "LoginTableViewController.h"
#import "User.h"

@implementation GroupListController {
    GroupListTableViewLogic *groupTableLogic;
    LoginTableViewController *logInViewController   ;
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"Group List";
        groupTableLogic = [[GroupListTableViewLogic alloc] init];
        logInViewController = [[LoginTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    }

    return self;
}

- (void)loadView {
    GroupListUIView *groupListUIView = [[GroupListUIView alloc] initWithDelegate:groupTableLogic andFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 49)];
    self.view = groupListUIView;
}

- (IBAction) createPress:(id) sender {

}

- (IBAction)reChargePress:(id) sender {

}

-(void) createBarButtonOnNavigationBar{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Recharge" style:UIBarButtonItemStylePlain target:self action:@selector(reChargePress:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(Logout:)];
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
}


@end