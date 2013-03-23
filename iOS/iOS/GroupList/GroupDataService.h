//
// Created by zhuanqingshan on 13-2-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface GroupDataService : NSObject
+ (NSArray *)groupListOfToday;
+ (BOOL) removeGroup:(NSString *)groupId;

+ (void)createGroupWithName:(NSString *)name restaurant:(NSString *)restaurant_id duedate:(NSString *)duedate;
@end