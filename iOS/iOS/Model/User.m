//
// Created by zhuanqingshan on 13-2-24.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "User.h"
#import "Settings.h"


@implementation User {

}
@synthesize token;
@synthesize name;
@synthesize email;


+ (User *)CurrentUser {
    NSString *username = [Settings getUserName];
    NSString *token = [Settings getUserToken];
    NSLog(@"current user: %@ token %@", username, token);
    return (username && token) ? [[User alloc] initWithName:username email:nil token:token] : nil;
}

- (id)initWithName:(NSString *)name email:(NSString *)email token:(NSString *)token {
    self.name = name;
    self.token = token;
    self.email = email;
    return self;
}


+ (void)SetCurrentUserName:(NSString *)name email:(NSString *)email token:(NSString *)token {
    [Settings setUserName:name];
    [Settings setUserEmail:email];
    [Settings setUserToken:token];
    NSLog(@"user logged in: %@ %@ %@",name, email, token);
}
@end