//
//  MXBaseRequest.m
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "MXBaseRequest.h"

@implementation MXBaseRequest

- (MXRequestCachePolicy)cachePolicy {
    return MXRequestCachePolicyReloadIgnoringLocalCacheData;
}

- (NSUInteger)cacheTimeOutInterval {
    return 0;
}

@end
