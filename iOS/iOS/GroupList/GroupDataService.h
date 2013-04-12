//
// Created by zhuanqingshan on 13-2-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface GroupDataService : NSObject
+ (NSArray *)groupListOfToday;
+ (BOOL) removeGroup:(NSString *)groupId;

+ (NSDictionary *)createGroupWithName:(NSString *)name restaurant:(NSString *)restaurant_id duedate:(NSString *)duedate;

+ (NSDictionary *)GetGroupById:(id)groupId;
+ (NSArray *)GetGroupDishes:(int)groupId;

+ (void)SubmitOrder:(NSMutableDictionary *)orders forGroup:(int)group;

+ (void)DeleteOrder:(int)orderId;
@end