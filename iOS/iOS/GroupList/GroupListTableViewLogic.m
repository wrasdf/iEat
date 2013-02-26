//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "GroupListProtocol.h"
#import "GroupListTableViewLogic.h"
#import "GroupSummaryViewCell.h"



@implementation GroupListTableViewLogic {
  enum{
      MyGroupSection = 0,
      OtherGroupSection,
      SectionCount
  };
}

@synthesize otherItems;
@synthesize myItems;

- (id)init {
    self = [super init];
    if (self) {
        otherItems = [NSArray arrayWithObjects:@"九头鹰",@"来福士",@"桂林米粉",nil];;
        myItems = [NSArray arrayWithObjects:@"咱家饺子",@"粥面故事",@"秦唐府",nil];;
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == MyGroupSection){
        return [myItems count];
    }
    else if(section == OtherGroupSection){
        return [otherItems count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == MyGroupSection){
        return @"My Groups";
    }
    else if (section == OtherGroupSection){
        return @"Other Groups";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *message;
    if (indexPath.section == MyGroupSection){
        message = [self.myItems objectAtIndex:(NSUInteger) indexPath.row];
    } else if (indexPath.section == OtherGroupSection){
        message = [self.otherItems objectAtIndex:(NSUInteger) indexPath.row];
    }
    [[[UIAlertView alloc] initWithTitle:@"Item Selected" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)configureCell:(GroupSummaryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell.imageView setImage:[UIImage imageNamed:@"fork.png"] ];
    cell.dueDateLabel.text = @"截止日期: 2013-02-23 11:00:00";
    cell.ownerLabel.text = @"邹明新";

    if (indexPath.section == MyGroupSection){
        cell.restaurantNameLabel.text = [self.myItems objectAtIndex:(NSUInteger) indexPath.row];
        cell.groupNameLabel.text = @"iEat小组";//[[self.myItems objectAtIndex:(NSUInteger) indexPath.row] stringByAppendingString:@"-thoughtworks 西宫"];
    } else if (indexPath.section == OtherGroupSection){
        cell.restaurantNameLabel.text = [self.otherItems objectAtIndex:(NSUInteger) indexPath.row];
        cell.groupNameLabel.text = @"thoughtworks east wing(test for a very very long name)";//[[self.otherItems objectAtIndex:(NSUInteger) indexPath.row] stringByAppendingString:@" thoughtworks-北京东直门店"];
    }
}


@end