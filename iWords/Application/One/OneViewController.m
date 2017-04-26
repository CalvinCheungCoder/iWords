//
//  OneViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "OneViewController.h"
#import "SearchViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"查词";
    [self createAddSearchBtn];
}

- (void)createAddSearchBtn
{
    
    UIButton *searchbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [searchbtn setImage:[UIImage imageNamed:@"home_search@2x"] forState:UIControlStateNormal];
    [searchbtn setImage:[UIImage imageNamed:@"home_search@2x"] forState:UIControlStateHighlighted];
    [searchbtn addTarget:self action:@selector(searchbtnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:searchbtn];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
}

- (void)searchbtnEvent
{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self presentViewController:search animated:YES completion:nil];
}

@end
