//
//  LanSwitchCell.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/13.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "LanSwitchCell.h"

@implementation LanSwitchCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = RGB(74, 74, 74);
        titleLabel.numberOfLines = 2;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *zdImg = [[UIImageView alloc]init];
        [self.contentView addSubview:zdImg];
        self.Img = zdImg;
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.Img.frame = CGRectMake(self.width-35, 15, 20, 20);
    self.titleLabel.frame = CGRectMake(20, 0, 100, self.height);
}

@end
