//
// Created by zhuanqingshan on 13-3-24.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol BillDataDelegate
- (NSDictionary *)getBillsInfo;
- (NSDictionary *)updateBillsInfo;
@end