//
//  MXBaseResponse.h
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXBaseResponse : NSObject

#define DylyResponseSuccessStatus 1

/** 缓存相关参数定义 */
@property (nonatomic,assign)NSDate *cacheDate;  /*! 缓存写入时间戳 */


/** 服务器放回相关参数定义 */
@property (nonatomic,strong)NSNumber *retCode;
@property (nonatomic,strong)NSString *retMessage;
@property (nonatomic,strong)NSString *pageCount;


@end
