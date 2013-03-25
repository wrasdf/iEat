//
//  OrderCellAccessory.m
//  iOS
//
//  Created by 颛 清山 on 03/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "OrderCellAccessory.h"

@implementation OrderCellAccessory
{
    UIButton *quantityBtn;
    UIButton *subtractBtn;
    int quantities;
    NSIndexPath *indexPath;
}


- (id)initWithIndexPath:(NSIndexPath *)path {
    indexPath = path;
    return [self initWithFrame:CGRectMake(0, 0, 60, 40)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        quantities = 0;
        quantityBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self updateQuantity];
        [self addSubview:quantityBtn];
        subtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [subtractBtn setImage:[UIImage imageNamed:@"no_entry.ico"] forState:UIControlStateNormal];
        [subtractBtn addTarget:self action:@selector(subtractQuantity:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:subtractBtn];
    }
    return self;
}

- (void)subtractQuantity:(id)sender {
    if (quantities> 0){
        quantities  = quantities -1;
    }
    [self updateQuantity];
}


- (void)updateQuantity {
    [quantityBtn setTitle:[NSString stringWithFormat:@"%d", quantities] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [quantityBtn setFrame:CGRectMake(0, 10, 25, 25)];
    [subtractBtn setFrame:CGRectMake(30, 10, 25, 25)];

    [super layoutSubviews];
}

- (void)increaseQuantity {
    quantities +=1;
    [self updateQuantity];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
