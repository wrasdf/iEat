//
//  RestaurantDataService.m
//  iOS
//
//  Created by 颛 清山 on 03/08/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RestaurantDataService.h"
#import "User.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@implementation RestaurantDataService
+ (NSArray *)restaurantList {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [@"http://localhost:3000/api/v1/restaurants?token=" stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startSynchronous];

    return [[request responseData] objectFromJSONData];
}

@end
