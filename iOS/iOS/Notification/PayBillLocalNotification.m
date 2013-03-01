//
//  PayBillLocalNotification.m
//  iOS
//
//  Created by 颛 清山 on 03/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PayBillLocalNotification.h"

@implementation PayBillLocalNotification
+ (void)scheduleBillNotification {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        notification.fireDate = date;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = NSYearCalendarUnit;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"XX团：宫保鸡丁 12￥";
        notification.applicationIconBadgeNumber = 12;
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"bill" forKey:@"bills"];
        notification.userInfo = infoDic;
        UIApplication *application = [UIApplication sharedApplication];
        [application scheduleLocalNotification:notification];
    }
}

+ (void)application:(UIApplication *)application showBillNotification:(UILocalNotification *)notification {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"交团费啦"
                                                    message:notification.alertBody
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:nil];
    [alert show];
    application.applicationIconBadgeNumber = 12;
}

+ (void)payBill {
    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *localNotification;
    for (UILocalNotification *notification in [app scheduledLocalNotifications]) {
        NSDictionary *dict = notification.userInfo;
        if (dict) {
            NSString *inKey = [dict objectForKey:@"bills"];
            if ([inKey isEqualToString:@"bill"]) {
                localNotification = notification;
                break;
            }
        }
    }

    if (localNotification) {
        [app cancelLocalNotification:localNotification];
        return;
    }
}


@end
