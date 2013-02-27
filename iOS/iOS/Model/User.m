//
// Created by zhuanqingshan on 13-2-24.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "User.h"


@implementation User {

}
+ (NSString *)CurrentUserName {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [standardUserDefault objectForKey:@"username"];
    NSLog(@"current user: %@", username);
    return username;
}


+ (id)SetCurrentUserName:(NSString *)name {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    [standardUserDefault setObject:name forKey:@"username"];
    NSLog(@"user logged in: %@",name);
    return nil;
}


@end