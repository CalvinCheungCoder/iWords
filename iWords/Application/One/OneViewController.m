//
//  OneViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "OneViewController.h"
#import "SearchViewController.h"
#import <PYSearch.h>

@interface OneViewController ()<PYSearchViewControllerDelegate>

// 搜索
@property (nonatomic, strong) NSMutableArray *searchArr;
// 搜索结果数组
@property (nonatomic, strong) NSMutableArray *searchArrTwo;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = DHLocalizedString(@"查词");
    [self createAddSearchBtn];
}

#pragma mark --
#pragma mark -- 创建搜索按钮
- (void)createAddSearchBtn
{
    
    UIButton *searchbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [searchbtn setImage:[UIImage imageNamed:@"home_search@2x"] forState:UIControlStateNormal];
    [searchbtn setImage:[UIImage imageNamed:@"home_search@2x"] forState:UIControlStateHighlighted];
    [searchbtn addTarget:self action:@selector(searchbtnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:searchbtn];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
}

#pragma mark --
#pragma mark -- 点击搜索
- (void)searchbtnEvent
{
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[@"good",@"try",@"fly",@"search",@"History"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:DHLocalizedString(@"搜索单词") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        MyLog(@"开始搜索");
        
        [NetManager GetDataByURL:[NSString stringWithFormat:@"%@%@",YouDaoSearchAPI,searchText] Parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
            MyLog(@"搜索结果 == %@",responseObject);
            
            
        } failBlock:^(NSURLSessionDataTask *operation, NSError *error) {
            
            MyLog(@"搜索失败 == %@",error.description);
        }];
        
    }];
    
    // 3. 设置风格
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag; // 搜索历史风格为default
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索风格为默认
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:^{
        // 设置状态栏颜色
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault)];
    }];
}

/**
 取消搜索
 */
- (void)didClickCancel:(PYSearchViewController *)searchViewController
{
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --
#pragma mark -- PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        
        MyLog(@"文本变化");
    }
}

/** 点击热门搜索时调用 */
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectHotSearchAtIndex:(NSInteger)index searchText:(NSString *)searchText
{
    
}
/** 点击搜索历史时调用 */
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchHistoryAtIndex:(NSInteger)index searchText:(NSString *)searchText
{
    
}

@end
