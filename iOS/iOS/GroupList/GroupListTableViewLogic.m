//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "GroupListProtocol.h"
#import "GroupListTableViewLogic.h"



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
    NSString *cellIdentifier = @"MyCellIdentifier"; // Attempt to request the reusable cell.

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.imageView setImage:[UIImage imageNamed:@"fork.png"] ];
    cell.detailTextLabel.text = @"Due Date: 2013-02-26 11:00:00";

    if (indexPath.section == MyGroupSection){
        cell.textLabel.text = [self.myItems objectAtIndex:(NSUInteger) indexPath.row];
    } else if (indexPath.section == OtherGroupSection){
        cell.textLabel.text = [self.otherItems objectAtIndex:(NSUInteger) indexPath.row];
    }

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


@end