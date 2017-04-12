//
//  AppDelegate.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/12.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBar.h"
#import "BaseViewController.h"
#import "GuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
//    [self chooseRootViewController];
    
//    BaseViewController *base = [[BaseViewController alloc]init];
//    self.window.rootViewController = base;
    
    // 获取根视图
    [Tools chooseRootViewController];
    // 设置启动页面停留时间
    [NSThread sleepForTimeInterval:1.0];
    
    return YES;
}

#pragma mark --
#pragma mark -- 选择根视图
- (void)chooseRootViewController{
    
    // 1. 取出沙盒中储存的上次使用软件的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    //NSLog(@"%@%@",lastVersion,lastVersion);
    // 2. 获得现在的版本号
    NSString *nowVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 3. 如果不相等 运行新特性
    if ([lastVersion isEqualToString: nowVersion])
    {
        self.window.rootViewController = [[MainTabBar alloc] init];
        //打开statusbar
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    else
    {
        self.window.rootViewController = [[GuideViewController alloc] init];
        //隐藏statusbar(信号栏)
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        //保存当前版本号，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:nowVersion forKey:@"key"];
        //马上生效
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
