//
//  GroupSummaryViewCell.h
//  iOS
//
//  Created by 颛 清山 on 13-2-26.
//  Copyright (c) 2013年 twer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroupSummaryViewCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *groupNameLabel;
    UILabel *ownerLabel;
    UILabel *dueDateLabel;
    UILabel *restaurantNameLabel;
}
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *groupNameLabel;
@property(nonatomic, strong) UILabel *ownerLabel;
@property(nonatomic, strong) UILabel *dueDateLabel;
@property(nonatomic, strong) UILabel *restaurantNameLabel;


@end
