//
//  GLGetAttentionDynamicListRequest.h
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "MXBaseRequest.h"

@interface GLGetDynamicListRequest : MXBaseRequest
@property (nonatomic,copy)NSString *topicId;
@property (nonatomic,copy)NSString *adSort;
@property (nonatomic,copy)NSNumber *timestamp;
@end
