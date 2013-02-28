//
//  RestaurantListViewController.h
//  iOS
//
//  Created by 颛 清山 on 02/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@class Restaurant;

@interface RestaurantListViewController : UITableViewController
{
    @private
    Restaurant *restaurant;
}
@property(nonatomic, strong) Restaurant *restaurant;


@end
