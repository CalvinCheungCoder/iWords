//
//  InviteViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "InviteViewController.h"
#import <UMSocialCore/UMSocialCore.h>

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
    NSString *str = @"如果你在使用 iWords 并且觉得不错的话,请帮忙分享给你的好友,谢谢！";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10.0f];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    label.attributedText = attributedString;
    label.textColor = RGB(74, 74, 74);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *shareBtnOne = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-75, label.bottom+80, 150, 50)];
    [shareBtnOne setBackgroundImage:[UIImage imageNamed:@"share_wechat"] forState:UIControlStateNormal];
    [shareBtnOne setBackgroundImage:[UIImage imageNamed:@"share_wechat"] forState:UIControlStateHighlighted];
    shareBtnOne.tag = 99;
    [shareBtnOne addTarget:self action:@selector(ShareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtnOne];
    
    UIButton *shareBtnTwo = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-75, shareBtnOne.bottom+30, 150, 50)];
    [shareBtnTwo setBackgroundImage:[UIImage imageNamed:@"share_wechatLine"] forState:UIControlStateNormal];
    [shareBtnTwo setBackgroundImage:[UIImage imageNamed:@"share_wechatLine"] forState:UIControlStateHighlighted];
    shareBtnTwo.tag = 100;
    [shareBtnTwo addTarget:self action:@selector(ShareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtnTwo];
}

- (void)ShareBtnClicked:(UIButton *)Btn
{
    if (Btn.tag == 99) {
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
    }else{
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
    }
}

#pragma mark --
#pragma mark -- 邀请好友(网页)
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我用 iWords 记单词已经很久了,邀请你也来" descr:@"我在使用 iWords--个人极简单词本 记录单词,App 清爽无广告,是学习英语的好工具,你也可以下载试试喔!" thumImage:[UIImage imageNamed:@"iwords_icon"]];
    //设置网页地址
    shareObject.webpageUrl = @"www.zhangdinghao.cn";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
