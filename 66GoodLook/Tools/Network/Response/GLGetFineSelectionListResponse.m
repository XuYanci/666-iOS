//
//  GLGetFineSelectionListResponse.m
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLGetFineSelectionListResponse.h"

@implementation GLGetFineSelectionListResDynamicModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"mediaList": [GLGetAttentionDynamicListResMediaListModel class],
             };
}
@end

@implementation GLGetFineSelectionListResActivityModel
@end

@implementation GLGetFineSelectionListResModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dynamic": [GLGetFineSelectionListResDynamicModel class],
             @"activity":[GLGetFineSelectionListResActivityModel class],
             };
}
@end

@implementation GLGetFineSelectionListResponse
@end
