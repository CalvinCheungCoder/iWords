//
//  Tools.m
//  RRL
//
//  Created by CalvinCheung on 16/11/18.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "Tools.h"
#import "MainTabBar.h"
#import "GuideViewController.h"
#import "SFHFKeychainUtils.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#define Key @"LocationVersion"

@implementation Tools

/**
 *  验证身份证号
 *
 *  @param cardNo <#cardNo description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray *codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner *scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}



/**
 验证银行卡

 @param cardNo <#cardNo description#>
 @return <#return value description#>
 */
+(BOOL)checkCardNo:(NSString*)cardNo{

    int sum = 0;
    NSInteger len = cardNo.length;
    int i = 0;
    
    while (i < len) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(len - 1 - i, 1)];
        int tmpVal = [tmpString intValue];
        if (i % 2 != 0) {
            tmpVal *= 2;
            if(tmpVal>=10) {
                tmpVal -= 9;
            }
        }
        sum += tmpVal;
        i++;
    }
    
    if((sum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 手机号码验证
 
 @param mobile 手机号
 @return 是否正确
 */
+ (BOOL) validateMobile:(NSString *)mobile{
    // 手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/**
*  删除USERDEFAULT里面的数据
*/
+ (void)removeUserdefault1{
    //方法一
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

// 方法二
+ (void)removeUserdefault2{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        // 不删除手机号和版本信息
        if (!([key isEqualToString:@"client_id"] || [key isEqualToString:@"secret"] || [key isEqualToString:@"LocationVersion"] || [key isEqualToString:@"netState"])) {
            [defs removeObjectForKey:key];
        }
    }
    [defs synchronize];
}

/**
 *  打印存储信息
 */
+ (void)logUserdefault{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        MyLog(@"userDefault 存储信息 -- %@ : %@",key,[Tools returnValueforKey:key]);
    }
    [defs synchronize];
}

/**
 *  在沙盒中添加键值对
 *
 *  @param value 值
 *  @param key   键
 */
+(void)addValue:(NSString *)value forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

/**
 *  获取沙盒中键对应的值
 *
 *  @param key 键
 *
 *  @return 值
 */
+(NSString *)returnValueforKey:(NSString *)key{
    //    NSString *key = @"AccountNumber";
    //  1.  取出沙盒中储存的上次使用软件的账号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults stringForKey:key];
    return value;
}


/**
 *  选择根视图控制器
 */
+ (void)chooseRootViewController{
    
    // 1. 取出沙盒中储存的上次使用软件的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:Key];
    // 2. 获得现在的版本号
    NSString *nowVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 3. 如果版本号相等 进入主页
    if (lastVersion.length == 0 || [lastVersion isEqualToString: nowVersion]) {
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBar alloc] init];
        // 打开statusbar
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
    }else{
        
        // 4. 如果版本号不相等 运行新特性
        [UIApplication sharedApplication].keyWindow.rootViewController = [[GuideViewController alloc] init];
        // 新特性展示时隐藏statusbar
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        // 保存当前版本号，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:nowVersion forKey:Key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 *  沙盒写入数据
 *
 *  @param fileName 文件名
 *  @param dataDic  数据字典
 *
 *  @return 写入是否成功
 */
+ (BOOL)writeToFile:(NSString*)fileName data:(NSMutableDictionary *)dataDic{
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.plist",fileName]];
    
    MyLog(@"%@",path);
    
    return [dataDic writeToFile:path atomically:YES];
}

/**
 *  打印沙盒路径
 */
+ (void)logSandBox{
    MyLog(@"沙盒路径为  %@", [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents"]]);
}

/**
 *  打电话
 *
 *  @param sender 电话号码
 */
+ (void)callDelAction:(NSString *)sender {
    UIWebView *webView = [[UIWebView alloc] init];
    NSURL *url             = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",sender]];
    NSURLRequest *request  = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

///**
// *  版本验证
// *
// *  @param block 是否为最新版本
// */
//+ (void)getVersionInfo:(void (^)(BOOL isLastVersion))block{
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
//    MyLog(@"当前版本号为------%@",currentVersion);
//    NSString *url = @"http://itunes.apple.com/cn/lookup?id=1180872996";
//    [Networking requestGetDataByURL:url Parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
//        
//        NSArray *infoContent = [responseObject objectForKey:@"results"];
//        NSString *lastVersion = [[infoContent objectAtIndex:0] objectForKey:@"version"];
//        NSString *iosUpVersionStr = [[infoContent objectAtIndex:0] objectForKey:@"releaseNotes"];
//        [Tools addValue:iosUpVersionStr forKey:iosUpVersionDes];
//        
//        NSString *curr = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//        NSString *last = [lastVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//        MyLog(@"%@%@",curr,last);
//        
//        // 本地版本号长度 <= 线上版本号长度
//        if (curr.length <= last.length) {
//            
//            if ([curr intValue] < [last intValue]) {
//                block(NO);
//            }else{
//                block(YES);
//            }
//        }else{
//            
//            curr = [curr substringToIndex:last.length];
//            if ([curr intValue] < [last intValue]) {
//                block(NO);
//            }else{
//                block(YES);
//            }
//        }
//        MyLog(@"最新的版本号为--------%@",lastVersion);
//    } failBlock:^(NSURLSessionDataTask *operation, NSError *error) {
//        MyLog(@"检查更新失败");
//        MyLog(@"error %@",error.localizedDescription);
//    }ReTry:^(BOOL res) {
//        
//    }];
//}


/**
 中间四位显示 * 的电话号码
 
 @param mobile 手机号
 @return 中间四位显示 * 的电话号码
 */
+(NSString *)returnStarMobile:(NSString *)mobile{
    
    NSString *tel = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return tel;
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 *  字段转换成json字符串
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)dictToJsonStr:(NSDictionary *)dict{
    
    NSString *jsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"json data:%@",jsonString);
        if (error) {
            NSLog(@"Error:%@" , error);
        }
    }
    return jsonString;
}

/**
 *  字典,数组转 JSON
 *
 *  @param object 需要被转换的类型对象,任意类型
 *
 *  @return JSON 字符串
 */
+ (NSString *)idObjectToJson:(id)object
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(UIView *)NoMessageView:(NSString *)message{

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backView.backgroundColor = RGB(246, 246, 246);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-50, ScreenHeight*0.45, 100, 100)];
    imageView.image = [UIImage imageNamed:@"noViewImage"];
    [backView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, imageView.bottom, ScreenWidth-40, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = message;
    [backView addSubview:titleLabel];
    
    return backView;
}


#pragma mark --
#pragma mark -- 获取唯一UUID
+ (NSString*)getUUID {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *userName = infoDict[@"CFBundleName"];
    NSString *serviceName = infoDict[@"CFBundleIdentifier"];
    NSString *uuid = [SFHFKeychainUtils getPasswordForUsername:userName andServiceName:serviceName error:nil];
    if (uuid.length==0) {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SFHFKeychainUtils storeUsername:userName andPassword:uuid forServiceName:serviceName updateExisting:1 error:nil];
    }
    return uuid;
}

#pragma mark --
#pragma mark -- 获取随机的 UUID
+ (NSString *)UUIDString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

#pragma mark --
#pragma mark -- 获取当前时间戳
+ (NSString*)getCurrentTime {
    
    NSDate *data = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [data timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];// 转为字符型
    return timeString;
}

#pragma mark --
#pragma mark -- 时间戳转字符串时间
+(NSString *)cStringFromTimestamp:(NSString *)timestamp{
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}

+(NSString *)cStringFromTimestampTwo:(NSString *)timestamp{
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}

+(NSString *)cStringFromTimestampThree:(NSString *)timestamp{
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}

+(NSString *)cStringFromTimestampFour:(NSString *)timestamp{
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}

+(NSString *)bankCrardStarStr:(NSString *)bankCardStr{
    
    NSString *newCard = [NSString new];
    if (bankCardStr.length == 16) {
        bankCardStr = [bankCardStr substringFromIndex:bankCardStr.length-4];
        newCard = [NSString stringWithFormat:@"****  ****  ****  %@",bankCardStr];
        
    }else if (bankCardStr.length > 16 && bankCardStr.length <= 19){
        bankCardStr = [bankCardStr substringFromIndex:bankCardStr.length-3];
        newCard = [NSString stringWithFormat:@"****  ****  ****  ****  %@",bankCardStr];
    }
    return newCard;
}

/**
 *  时间戳转成字符串
 *
 *  @param timestamp 时间戳
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter *dateFormtter =[[NSDateFormatter alloc] init];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSTimeInterval late=[d timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    else if (cha/86400>1&&cha/86400*3<1)     //86400 = 60(分)*60(秒)*24(小时)   3天内
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else
    {
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:d];
    }
    
    return timeString;
}

// 获取当前时间
+ (NSString*)getCurrentTimeTwo {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}


//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

@end
