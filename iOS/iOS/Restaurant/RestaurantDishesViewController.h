//
//  RestaurantDishesViewController.h
//  iOS
//
//  Created by 颛 清山 on 03/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



#import "OrderCellAccessory.h"

@interface RestaurantDishesViewController : UITableViewController<UISearchBarDelegate, OrderCellAccessoryDelegate>

- (id)initWithGroupId:(int)groupId;
@end
