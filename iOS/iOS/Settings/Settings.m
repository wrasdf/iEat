//
//  Settings.m
//  iOS
//
//  Created by 颛 清山 on 03/31/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings


+ (NSString *)serverUri {
    return @"http://localhost:3000";
    return @"https://10.18.7.120";
}

+ (void)setUserName:(NSString *)username {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    [standardUserDefault setObject:username forKey:@"username"];
}

+ (void)setUserToken:(NSString *)token {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    [standardUserDefault setObject:token forKey:@"token"];
}

+ (void)setUserEmail:(NSString *)email {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    [standardUserDefault setObject:email forKey:@"email"];
}

+ (NSString *)getUserName {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    return [standardUserDefault objectForKey:@"username"];
}

+ (NSString *)getUserToken {
//    return @"wrong_token";
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    return [standardUserDefault objectForKey:@"token"];
}

+ (NSString *)getUserEmail {
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    return [standardUserDefault objectForKey:@"email"];
}


@end
