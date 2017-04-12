//
//  Tools.h
//  RRL
//
//  Created by CalvinCheung on 16/11/18.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

/**
 *  验证身份证号
 *
 *  @param cardNo 身份证号
 *
 *  @return 是否正确
 */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;


/**
 验证银行卡号

 @param cardNo 卡号
 @return 是否正确
 */
+(BOOL)checkCardNo:(NSString*)cardNo;


/**
 手机号码验证

 @param mobile 手机号
 @return 是否正确
 */
+ (BOOL) validateMobile:(NSString *)mobile;


/**
 *  删除USERDEFAULT里面的数据
 */
+ (void)removeUserdefault1;

// 方法二
+ (void)removeUserdefault2;

/**
 *  打印存储信息
 */
+ (void)logUserdefault;


/**
 *  在沙盒中添加键值对
 *
 *  @param value 值
 *  @param key   键
 */
+(void)addValue:(NSString *)value forKey:(NSString *)key;


/**
 *  获取沙盒中键对应的值
 *
 *  @param key 键
 *
 *  @return 值
 */
+(NSString *)returnValueforKey:(NSString *)key;

/**
 *  选择根视图控制器
 */
+ (void)chooseRootViewController;

/**
 *  沙盒写入数据
 *
 *  @param fileName 文件名
 *  @param dataDic  数据字典
 *
 *  @return 写入是否成功
 */
+ (BOOL)writeToFile:(NSString*)fileName data:(NSMutableDictionary *)dataDic;

/**
 *  打印沙盒路径
 */
+ (void)logSandBox;

/**
 *  打电话
 *
 *  @param sender 电话号码
 */
+ (void)callDelAction:(NSString *)sender;

/**
 *  版本验证
 *
 *  @param block 是否为最新版本
 */
//+ (void)getVersionInfo:(void (^)(BOOL isLastVersion))block;


/**
 中间四位显示 * 的电话号码

 @param mobile 手机号
 @return 中间四位显示 * 的电话号码
 */
+ (NSString *)returnStarMobile:(NSString *)mobile;

/**
 字符串转字典

 @param jsonString 字符串
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 字段转换成json字符串

 @param dict Dict
 @return Json字符串
 */
+(NSString *)dictToJsonStr:(NSDictionary *)dict;


/**
 获取uuid

 @return uuid
 */
+ (NSString*)getUUID;


/**
 获取当前时间戳

 @return 当前时间戳
 */
+ (NSString*)getCurrentTime;


/**
 获取当前时间

 @return 当前时间
 */
+ (NSString*)getCurrentTimeTwo;

/**
 *  字典,数组转 JSON
 *
 *  @param object 需要被转换的类型对象,任意类型
 *
 *  @return JSON 字符串
 */
+ (NSString *)idObjectToJson:(id)object;



/**
 获取随机的 UUID

 @return 随机的 UUID
 */
+ (NSString *)UUIDString;

/**
 *  时间戳转成字符串
 *
 *  @param timestamp 时间戳
 *
 *  @return 格式化后的字符串
 */
+(NSString *)cStringFromTimestamp:(NSString *)timestamp;

+(NSString *)cStringFromTimestampTwo:(NSString *)timestamp;

+(NSString *)cStringFromTimestampThree:(NSString *)timestamp;

+(NSString *)cStringFromTimestampFour:(NSString *)timestamp;

+(NSString *)bankCrardStarStr:(NSString *)bankCardStr;

+ (NSString *)timeFromTimestamp:(NSInteger)timestamp;


/**
 获取设备型号

 @return 设备型号
 */
+ (NSString *)getCurrentDeviceModel;

@end
