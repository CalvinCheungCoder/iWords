//
//  BaseViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UIImageView *navBarHairlineImageView;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(236, 236, 236);
    
    [self setNavigation];
}

- (void)setNavigation{
    
    // 状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:RGB(39, 152, 227)];
    // 导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 去除黑线
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    // 导航栏背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack@2x"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
