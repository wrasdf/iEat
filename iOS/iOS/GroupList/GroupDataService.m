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
const NSString * serverUrl = @"http://localhost:3000";

+ (NSArray *)groupListOfToday {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?token=%@", serverUrl, @"/api/v1/groups/active", token];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startSynchronous];

    return [[request responseData] objectFromJSONData];

}

+ (BOOL)removeGroup:(NSString *)groupId {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverUrl, @"/groups/1"]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"DELETE"];
    [request setDelegate:self];
    [request startSynchronous];
    int statusCode = [request responseStatusCode];
    return statusCode;
}


+ (NSDictionary *)createGroupWithName:(NSString *)name restaurant:(NSString *)restaurant_id duedate:(NSString *)duedate {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", serverUrl, @"/api/v1/groups/create"];

    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:token forKey:@"token"];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:restaurant_id forKey:@"restaurant_id"];
    [request setPostValue:duedate forKey:@"due_date"];
    [request setRequestMethod:@"POST"];

    [request setDelegate:self];
    [request startSynchronous];
    NSData *data = [request responseData];
    return [data objectFromJSONData];
}

+ (NSDictionary *)GetGroupById:(id)groupId {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%d?token=%@", serverUrl, @"/api/v1/groups/", groupId, token];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startSynchronous];

    return [[request responseData] objectFromJSONData];
}
@end