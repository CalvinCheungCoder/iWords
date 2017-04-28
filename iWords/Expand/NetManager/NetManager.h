//
//  NetManager.h
//  iWords
//
//  Created by 张丁豪 on 2017/4/28.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetManager : NSObject

// 请求成功之后回调的 Block
typedef void(^SuccessBlock) (NSURLSessionDataTask *operation, id responseObject);

// 重新请求
typedef void(^ReTry) (BOOL res);

// 网络结果
typedef void(^netState) (BOOL res);

// 请求失败之后回调的 Block
typedef void(^FailBlock) (NSURLSessionDataTask *operation, NSError *error);

#pragma mark --
#pragma mark -- Get请求
+ (void)GetDataByURL:(NSString *)URL Parameters:(NSDictionary *)parameters success:(SuccessBlock)success failBlock:(FailBlock)fail;

#pragma mark --
#pragma mark -- 未加密Post请求方法
+(void)PostDataByURL:(NSString *)URL Parameters:(NSDictionary *)parameters success:(SuccessBlock)success failBlock:(FailBlock)fail;

// 网络状态
+(void)netState:(netState)NetSate;

@end
