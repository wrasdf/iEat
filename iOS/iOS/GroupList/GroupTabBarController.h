//
//  GroupTabBarController.h
//  iOS
//
//  Created by 颛 清山 on 03/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



#import "GroupDataDelegate.h"

@interface GroupTabBarController : UITabBarController<GroupDataDelegate>

- (id)initWithGroupId:(id)groupId;


@end
