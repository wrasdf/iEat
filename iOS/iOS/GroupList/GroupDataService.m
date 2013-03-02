//
// Created by zhuanqingshan on 13-2-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupDataService.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "User.h"


@implementation GroupDataService {

}
+ (NSDictionary *)groupListOfToday {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [@"http://localhost:3000/api/v1/groups/active?token=" stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startSynchronous];
    NSString *responseString = [request responseString];
    NSData *data = [request responseData];
    NSDictionary * result = [data objectFromJSONData];

    return result;

}

+ (BOOL)removeGroup:(NSString *)groupId {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/groups/1"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setPostBody:nil];
    [request setRequestMethod:@"DELETE"];
    [request setDelegate:self];
    [request startSynchronous];
    int statusCode = [request responseStatusCode];
    return statusCode;
}


@end