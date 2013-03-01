//
//  PayBillLocalNotification.h
//  iOS
//
//  Created by 颛 清山 on 03/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@interface PayBillLocalNotification : UILocalNotification
     +(void)scheduleBillNotification;
+(void)application:(UIApplication *)application showBillNotification:(UILocalNotification *)notification;
+(void)payBill;
@end
