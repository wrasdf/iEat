//
//  OrderCellAccessory.h
//  iOS
//
//  Created by 颛 清山 on 03/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

@protocol OrderCellAccessoryDelegate <NSObject>

@optional
- (void)updateQuantityAtIndexPath:(NSIndexPath *)indexPath withQuantity:(int)quantity;
@end

@interface OrderCellAccessory : UIView

@property (nonatomic, strong) NSObject <OrderCellAccessoryDelegate> *delegate;
- (void)increaseQuantity;
- (id)initWithIndexPath:(NSIndexPath *)path;
@end
