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
#import <UMSocialCore/UMSocialCore.h>

#define UMengAppKey @"58f091a3f29d9870a900034c"
#define WeChatAppID @"wx9a570a5189841fb7"
#define WeChatAppSecret @"90f2683d208e71d1ab37ac06288a8120"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setUMengShare];
    // 初始化语言
    [DHLanguageTool initUserLanguage];
    // 获取根视图
    [Tools chooseRootViewController];
    // 设置启动页面停留时间
//    [NSThread sleepForTimeInterval:0.8];
    
    return YES;
}

#pragma mark --
#pragma mark -- 友盟分享
- (void)setUMengShare{
    
    // 打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    // 设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengAppKey];
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    // 设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppID appSecret:WeChatAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@""  appSecret:@"" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
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
