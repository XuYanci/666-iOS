//
//  MXBaseUrl.h
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>
 
/*! 服务器url前缀*/
#define MAXER_URL_PREFIX                    @"http://re30.66yxq.com:8075/gateway-web/"
/*! url拼接*/
#define MAXER_URL_LINK(prefix , suffix)     [NSString stringWithFormat:@"%@%@",prefix,suffix]
/*! 请求超时时间 */
#define DYLY_REQUEST_TIMEOUT                10


@interface MXBaseUrl : NSObject

/**
 根据method获取URL字符串
 @param method 方法名称
 @return URL字符串
 */
+ (NSString *)baseUrl:(NSString *)method;
/**
 根据method获取URL字符串
 @param method 方法名称
 @param params 参数,这里指的是Get请求键值对,这里只支持字符串
 @return URL字符串
 */
+ (NSString *)baseUrlWithParams:(NSString *)method params:(NSDictionary *)params;
@end
