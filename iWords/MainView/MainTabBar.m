//
//  MainTabBar.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "MainTabBar.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface MainTabBar ()<UITabBarControllerDelegate>

@property(nonatomic, assign) NSInteger tabBarIndex;

@property(nonatomic , weak) UIButton *hideBtn;

@property (nonatomic, assign) NSInteger currentItemTag;//当前被选中选项卡的标签号

@end

@implementation MainTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建子控制器
    [self createSubViewControllers];
    // 设置所有的、分栏元素项
    [self setTabBarItems];
}

#pragma mark --
#pragma mark -- 创建子控制器
- (void)createSubViewControllers{
    
    OneViewController *One = [[OneViewController alloc]init];
    CustomNavigationController *navOne = [[CustomNavigationController alloc]initWithRootViewController:One];
    navOne.fullScreenPopGestureEnabled = YES;
    
    TwoViewController *Two = [TwoViewController new];
    CustomNavigationController *navTwo = [[CustomNavigationController alloc]initWithRootViewController:Two];
    navTwo.fullScreenPopGestureEnabled = YES;
    
    ThreeViewController *Three = [[ThreeViewController alloc]init];
    CustomNavigationController *navThree = [[CustomNavigationController alloc]initWithRootViewController:Three];
    navThree.fullScreenPopGestureEnabled = YES;
    
    self.delegate = self;
    self.viewControllers = @[navOne,navTwo,navThree];
}

#pragma mark --
#pragma mark -- 设置所有的、分栏元素项
- (void)setTabBarItems{
    
    NSArray *titleArr = @[DHLocalizedString(@"查单词"),DHLocalizedString(@"记单词"),DHLocalizedString(@"我")];
    NSArray *normalImgArr = @[@"search",@"record",@"my"];
    NSArray *selectedImgArr = @[@"searchSele",@"recordSele",@"mySele"];
    
    for (int i = 0; i<titleArr.count; i++) {
        UIViewController *vc = self.viewControllers[i];
        
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:[[UIImage imageNamed:selectedImgArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
        vc.tabBarItem.tag = i+1;
    }
    
    // TabbarItem选中时字体颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(39, 152, 227)} forState:UIControlStateSelected];
    
    // 消除Tabbar黑线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    // 设置Tabbar背景色
    [[UITabBar appearance]setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    
    // self.navigationController.navigationBar 这个的话会有一个专题改不了，所以这用最高权限
    // 获取导航条最高权限
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}

#pragma mark - Override
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    self.currentItemTag = item.tag;
    //    MyLog(@"%ld", (long)item.tag)
}

#pragma mark - UITabBarControllerDelegate
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

//    if (self.currentItemTag == 4) {
//
//        if (![LoginState isLogin]) {
//
//            LoginInViewController *login = [[LoginInViewController alloc]init];
//            login.come = 1;
//            CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:login];
//            [self presentViewController:nav animated:YES completion:nil];
//
//            return NO;
//        }else{
//            return YES;
//        }
//    }else{
        return YES;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
