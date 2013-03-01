//
// Created by zhuanqingshan on 13-2-24.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "User.h"


@implementation User {

}
@synthesize token;
@synthesize name;


+ (User *)CurrentUser {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [standardUserDefault objectForKey:@"username"];
    NSString *token = [standardUserDefault objectForKey:@"token"];
    NSLog(@"current user: %@ token %@", username, token);
    return (username && token) ? [[User alloc]initWithName:username token:token] : nil;
}

- (id)initWithName:(NSString *)name token:(NSString *)token {
    self.name = name;
    self.token = token;
    return self;
}


+ (id)SetCurrentUserName:(NSString *)name token:(NSString *)token {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    [standardUserDefault setObject:name forKey:@"username"];
    [standardUserDefault setObject:token forKey:@"token"];
    NSLog(@"user logged in: %@ %@",name, token);
    return nil;
}


@end