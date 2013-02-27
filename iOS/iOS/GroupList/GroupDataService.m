//
// Created by zhuanqingshan on 13-2-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GroupDataService.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"


@implementation GroupDataService {

}
+ (NSDictionary *)groupListOfToday {
    //Start request
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/groups/today"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request startSynchronous];
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