//
// Created by zhuanqingshan on 13-4-4.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BillDataService.h"
#import "User.h"
#import "Settings.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"


@implementation BillDataService {

}
+ (NSDictionary *)myBills {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?token=%@", Settings.serverUri, @"/api/v1/mybills", token];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startSynchronous];
    NSDictionary *jsonData = [[request responseData] objectFromJSONData];
    NSLog([jsonData JSONString]);
    return jsonData;
}

+ (void)payOffBill:(int)billId {
    NSString *token = [[User CurrentUser] token];
    NSString *urlString = [NSString stringWithFormat:@"%@/api/v1/mybills/paid/%d?token=%@", Settings.serverUri, billId, token];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setValidatesSecureCertificate:NO];
//    [request setPostValue:token forKey:@"token"];
//    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startSynchronous];
    NSLog([request responseString]) ;
}


@end