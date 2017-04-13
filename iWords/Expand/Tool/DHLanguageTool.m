//
//  DHLanguageTool.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/13.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//


#import "DHLanguageTool.h"
#import "MainTabBar.h"

static DHLanguageTool *currentLanguage;

@implementation DHLanguageTool

static NSBundle *bundle = nil;

// 获取当前资源文件
+ (NSBundle *)bundle{
    return bundle;
}

// 初始化语言文件
+ (void)initUserLanguage{
    
    NSString *languageString = [[NSUserDefaults standardUserDefaults] valueForKey:DHLanguageKey];
    if(languageString.length == 0){
        // 获取系统当前语言版本
        NSArray *languagesArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        languageString = languagesArray.firstObject;
        [[NSUserDefaults standardUserDefaults] setValue:languageString forKey:@"userLanguage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    // 避免缓存会出现 zh-Hans-CN 及其他语言的的情况
    if ([[DHLanguageTool SimplifiedChinese] containsObject:languageString]) {
        languageString = [[DHLanguageTool SimplifiedChinese] firstObject]; // 中文
        
    } else if ([[DHLanguageTool english] containsObject:languageString]) {
        languageString = [[DHLanguageTool english] firstObject]; // 英文
        
    }else if ([[DHLanguageTool TraditionalChinese] containsObject:languageString]) {
        languageString = [[DHLanguageTool TraditionalChinese] firstObject]; // 繁体中文
        
    } else {
        languageString = [[DHLanguageTool SimplifiedChinese] firstObject]; // 其他默认为中文
    }
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:languageString ofType:@"lproj"];
    // 生成bundle
    bundle = [NSBundle bundleWithPath:path];
}

// 英文类型数组
+ (NSArray *)english {
    return @[@"en"];
}

// 简体中文类型数组
+ (NSArray *)SimplifiedChinese{
    return @[@"zh-Hans"];
}

// 繁体中文类型数组
+ (NSArray *)TraditionalChinese{
    return @[@"zh-Hant"];
}


// 获取应用当前语言
+ (NSString *)userLanguage {
    NSString *languageString = [[NSUserDefaults standardUserDefaults] valueForKey:DHLanguageKey];
    return languageString;
}

// 设置当前语言
+ (void)setUserlanguage:(NSString *)language {
    
    if([[self userLanguage] isEqualToString:language]) return;
    // 改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    // 持久化
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:DHLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = nil;
    if ([UIApplication sharedApplication].keyWindow.rootViewController == nil) {
        MainTabBar *tabBar = [[MainTabBar alloc] init];
        tabBar.selectedIndex = 2;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
        
        setToast(DHLocalizedString(@"语言切换成功"));
    }
}

@end
