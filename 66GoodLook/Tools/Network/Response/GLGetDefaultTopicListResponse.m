//
//  GLGetDefaultTopicListResponse.m
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLGetDefaultTopicListResponse.h"

@implementation GLGetDefaultTopicListModel
@end

@implementation GLGetDefaultTopicListResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"result": [GLGetDefaultTopicListModel class],
             };
}
@end
