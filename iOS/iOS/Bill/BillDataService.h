//
// Created by zhuanqingshan on 13-4-4.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface BillDataService : NSObject
+ (NSDictionary *)myBills;
+ (void)payOffBill:(int)billId;
@end