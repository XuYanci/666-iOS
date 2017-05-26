//
//  GLGetAttentionDynamicListResponse.m
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLGetDynamicListResponse.h"

@implementation GLGetAttentionDynamicListResMediaListModel

@end

@implementation GLGetAttentionDynamicListResDynamicModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"mediaList": [GLGetAttentionDynamicListResMediaListModel class],
             };
}
@end

@implementation GLGetAttentionDynamicListResModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dynamic": [GLGetAttentionDynamicListResDynamicModel class],
            };
}
@end

@implementation GLGetDynamicListResponse

@end
