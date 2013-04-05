//
//  Settings.h
//  iOS
//
//  Created by 颛 清山 on 03/31/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@interface Settings : NSObject
+ (NSString *)serverUri;
+ (void) setUserName:(NSString *)username;
+ (void) setUserToken:(NSString *)token;
+ (void) setUserEmail:(NSString *)email;
+ (NSString *)getUserName;
+ (NSString *)getUserToken;
+ (NSString *)getUserEmail;
@end
