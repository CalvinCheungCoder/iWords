//
//  InviteViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "InviteViewController.h"

@interface InviteViewController ()

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = DHLocalizedString(@"邀请好友");
    
    [self createShareUI];
}

- (void)createShareUI
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, ScreenWidth-60, 60)];
    label.textColor = RGB(74, 74, 74);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    NSString *str = @"如果你在使用 iWords 并且觉得不错的话,请帮忙分享给你的好友,谢谢！";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10.0f];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *shareBtnOne = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-75, label.bottom+80, 150, 50)];
    [shareBtnOne setBackgroundImage:[UIImage imageNamed:@"share_wechat"] forState:UIControlStateNormal];
    [shareBtnOne setBackgroundImage:[UIImage imageNamed:@"share_wechat"] forState:UIControlStateHighlighted];
    [self.view addSubview:shareBtnOne];
    
    UIButton *shareBtnTwo = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-75, shareBtnOne.bottom+30, 150, 50)];
    [shareBtnTwo setBackgroundImage:[UIImage imageNamed:@"share_wechatLine"] forState:UIControlStateNormal];
    [shareBtnTwo setBackgroundImage:[UIImage imageNamed:@"share_wechatLine"] forState:UIControlStateHighlighted];
    [self.view addSubview:shareBtnTwo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
