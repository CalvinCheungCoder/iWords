//
//  DHLanguageTool.h
//  iWords
//
//  Created by 张丁豪 on 2017/4/13.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#define DHLocalizedString(key)  [[DHLanguageTool bundle] localizedStringForKey:(key) value:@"" table:@"DHLocalizable"]

#import <Foundation/Foundation.h>

#define DHLanguageKey @"userLanguage"

#define DHSimplifiedChinese @"zh-Hans"

#define DHTraditionalChinese @"zh-Hant"

#define DHEnglish @"en"


@interface DHLanguageTool : NSObject

/**
 *  获取当前资源文件
 */
+ (NSBundle *)bundle;

/**
 *  初始化语言文件
 */
+ (void)initUserLanguage;

/**
 *  获取应用当前语言
 */
+ (NSString *)userLanguage;

/**
 *  设置当前语言
 */
+ (void)setUserlanguage:(NSString *)language;


@end
