//
//  MXBaseRequest.h
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  @typedef 缓存策略
 */
typedef NS_ENUM(NSUInteger, MXRequestCachePolicy) {
    /*!直接忽略本地缓存直接请求,本地不会缓存Response*/
    MXRequestCachePolicyReloadIgnoringLocalCacheData,
    /*!如果本地有缓存则取缓存,否则请求 本地会缓存Response*/
    MXRequestCachePolicyReturnCacheDataElseLoad,
};


@interface MXBaseRequest : NSObject
/*! 请求缓存策略 */
@property (nonatomic,assign)MXRequestCachePolicy cachePolicy;
/*! 缓存超时时间 以天为单位:86400 秒*/
@property (nonatomic,assign)NSUInteger cacheTimeOutInterval;



@end
