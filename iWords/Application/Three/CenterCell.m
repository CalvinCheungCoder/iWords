//
//  CenterCell.m
//  swift001
//
//  Created by 张丁豪 on 2017/4/11.
//  Copyright © 2017年 123. All rights reserved.
//

#import "CenterCell.h"

@implementation CenterCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = RGB(74, 74, 74);
        titleLabel.numberOfLines = 2;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:timeLabel];
        self.detailLabel = timeLabel;
        
        UIImageView *zdImg = [[UIImageView alloc]init];
        [self.contentView addSubview:zdImg];
        self.Img = zdImg;
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = RGB(236, 236, 236);
        [self.contentView addSubview:lineView];
        self.linView = lineView;
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.Img.frame = CGRectMake(10, 15, 20, 20);
    self.titleLabel.frame = CGRectMake(40, 0, self.width-145, self.height);
    self.detailLabel.frame = CGRectMake(self.width-100, 0, 90, self.height);
    self.linView.frame = CGRectMake(0, self.height-0.8, ScreenWidth, 0.8);
}

@end
