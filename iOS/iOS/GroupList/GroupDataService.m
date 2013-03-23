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
+ (NSArray *)groupListOfToday {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [@"http://localhost:3000/api/v1/groups/active?token=" stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startSynchronous];

    return [[request responseData] objectFromJSONData];

}

+ (BOOL)removeGroup:(NSString *)groupId {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/groups/1"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"DELETE"];
    [request setDelegate:self];
    [request startSynchronous];
    int statusCode = [request responseStatusCode];
    return statusCode;
}


+ (void)createGroupWithName:(NSString *)name restaurant:(NSString *)restaurant_id duedate:(NSString *)duedate {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = @"http://localhost:3000/api/v1/groups/create";
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setPostValue:token forKey:@"token"];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:restaurant_id forKey:@"restaurant_id"];
    [request setPostValue:duedate forKey:@"due_date"];
    [request setRequestMethod:@"POST"];

//    [request addRequestHeader:@"restaurant_id" value:restaurant_id];
//    [request addRequestHeader:@"due_date" value:duedate];
//    [request addRequestHeader:@"name" value:name];
    [request setDelegate:self];
    [request startSynchronous];
    NSString *responseString = [request responseString];
    NSData *data = [request responseData];
    NSDictionary * result = [data objectFromJSONData];

}
@end