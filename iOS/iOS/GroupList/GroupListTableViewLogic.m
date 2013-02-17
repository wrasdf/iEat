//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "GroupListProtocol.h"
#import "GroupListTableViewLogic.h"



@implementation GroupListTableViewLogic {

}

- (id)init {
    self = [super init];
    if (self) {
        self.items = [NSArray arrayWithObjects:@"九头鹰",@"来福士",@"桂林米粉",nil];;
    }

    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Identifier for retrieving reusable cells. static NSString
    NSString *cellIdentifier = @"MyCellIdentifier"; // Attempt to request the reusable cell.

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.items objectAtIndex:(NSUInteger) indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    UIAlertView *alert = [[UIAlertView alloc]

            initWithTitle:@"Item Selected"

                 message:[self.items objectAtIndex:(NSUInteger) indexPath.row]

                 delegate:self

        cancelButtonTitle:@"OK"

        otherButtonTitles:nil];

    [alert show];



}


@end