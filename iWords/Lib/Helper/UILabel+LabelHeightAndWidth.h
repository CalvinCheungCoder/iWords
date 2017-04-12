//
//  UILabel+LabelHeightAndWidth.h
//  RRL
//
//  Created by 张丁豪 on 2017/2/15.
//  Copyright © 2017年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeightAndWidth)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
