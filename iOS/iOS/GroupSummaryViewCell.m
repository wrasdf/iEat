//
//  GroupSummaryViewCell.m
//  iOS
//
//  Created by 颛 清山 on 13-2-26.
//  Copyright (c) 2013年 twer. All rights reserved.
//

#import "GroupSummaryViewCell.h"

@interface GroupSummaryViewCell (SubviewFrames)
- (CGRect)_imageViewFrame;
- (CGRect)_groupNameLabelFrame;
- (CGRect)_dueDateLabelFrame;
- (CGRect)_ownerLabelFrame;
- (CGRect)_restaurantLabelFrame;
@end

@implementation GroupSummaryViewCell
@synthesize imageView;
@synthesize groupNameLabel;
@synthesize ownerLabel;
@synthesize dueDateLabel;
@synthesize restaurantNameLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];

        groupNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [groupNameLabel setBackgroundColor:[UIColor clearColor]];
        [groupNameLabel setFont:[UIFont boldSystemFontOfSize:14.0] ];
        [groupNameLabel setTextColor:[UIColor blackColor]];
        [groupNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:groupNameLabel];

        ownerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [ownerLabel setBackgroundColor:[UIColor clearColor]];
        [ownerLabel setFont:[UIFont systemFontOfSize:12.0]];
        [ownerLabel setTextColor:[UIColor darkGrayColor]];
        [ownerLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:ownerLabel];

        dueDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [dueDateLabel setBackgroundColor:[UIColor clearColor]];
        [dueDateLabel setFont:[UIFont systemFontOfSize:12.0]];
        [dueDateLabel setTextColor:[UIColor darkGrayColor]];
        [dueDateLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:dueDateLabel];

        restaurantNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [restaurantNameLabel setBackgroundColor:[UIColor clearColor]];
        [restaurantNameLabel setFont:[UIFont systemFontOfSize:12.0]];
        [restaurantNameLabel setTextColor:[UIColor darkGrayColor]];
        [restaurantNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:restaurantNameLabel];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [imageView setFrame:[self _imageViewFrame]];
    [groupNameLabel setFrame:[self _groupNameLabelFrame]];
    [dueDateLabel setFrame:[self _dueDateLabelFrame]];
    [ownerLabel setFrame:[self _ownerLabelFrame]];
    [restaurantNameLabel setFrame:[self _restaurantLabelFrame]];
    if (self.editing) {
        ownerLabel.alpha = 0.0;
    } else {
        ownerLabel.alpha = 1.0;
    }
}


#define IMAGE_SIZE          32.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0
#define OWNER_WIDTH         60.0

- (CGRect)_imageViewFrame {
    if (self.editing) {
        return CGRectMake(EDITING_INSET, 10.0, IMAGE_SIZE, IMAGE_SIZE);
    }
    else {
        return CGRectMake(EDITING_INSET/2, 10.0, IMAGE_SIZE, IMAGE_SIZE);
    }
}

- (CGRect)_restaurantLabelFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 12.0);
    }
    else {
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 - OWNER_WIDTH, 12.0);
    }
}

- (CGRect)_groupNameLabelFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 20.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 16.0);
    }
    else {
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 20.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 , 16.0);
    }
}

- (CGRect)_dueDateLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    if (self.editing)
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 40.0, contentViewBounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 12.0);
    else
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 40.0, contentViewBounds.size.width - IMAGE_SIZE - TEXT_LEFT_MARGIN, 12.0);
}

- (CGRect)_ownerLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - OWNER_WIDTH - TEXT_RIGHT_MARGIN, 4.0, OWNER_WIDTH, 12.0);
}


@end
