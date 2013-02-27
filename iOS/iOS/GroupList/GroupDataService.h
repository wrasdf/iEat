//
// Created by zhuanqingshan on 13-2-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface GroupDataService : NSObject
+ (NSDictionary *) groupListOfToday;
+ (BOOL) removeGroup:(NSString *)groupId;
@end