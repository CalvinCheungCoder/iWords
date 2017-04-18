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
    
    UIButton *addbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [addbtn setImage:[UIImage imageNamed:@"add_word"] forState:UIControlStateNormal];
    [addbtn setImage:[UIImage imageNamed:@"add_word"] forState:UIControlStateHighlighted];
    [addbtn addTarget:self action:@selector(addBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:addbtn];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
}

- (void)addBtnEvent
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
