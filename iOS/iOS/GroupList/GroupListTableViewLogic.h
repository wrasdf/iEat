//
// Created by twer on 2/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol GroupListProtocol;

@interface GroupListTableViewLogic : NSObject
@property (nonatomic,strong) NSArray * items;
@property (nonatomic,strong) id<GroupListProtocol> delegate;

@end