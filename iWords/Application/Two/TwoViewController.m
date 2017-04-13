//
//  TwoViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = DHLocalizedString(@"记单词");
    
    [self createAddBtn];
}

- (void)createAddBtn
{
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70, ScreenHeight-64-49-60, 35, 35)];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add_word"] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add_word"] forState:UIControlStateHighlighted];
    [self.view addSubview:addBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
