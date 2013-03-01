//
// Created by zhuanqingshan on 13-2-24.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface User : NSObject
{
    NSString *name;
    NSString *token;
}
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *name;


+ (User *)CurrentUser;

- (id)initWithName:(NSString *)name token:(NSString *)token;

+ (id)SetCurrentUserName:(NSString *)name token:(NSString *)token;
@end