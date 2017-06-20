//
//  GLGetAttentionDynamicListResponse.h
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "MXBaseResponse.h"

@interface GLGetAttentionDynamicListResMediaListModel : NSObject
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSNumber *width;
@property (nonatomic,copy) NSNumber *height;
@property (nonatomic,copy) NSNumber *type;
@property (nonatomic,copy) NSNumber *duration;
@property (nonatomic,copy) NSNumber *startX;
@property (nonatomic,copy) NSNumber *startY;
@property (nonatomic,copy) NSNumber *cropWidth;
@property (nonatomic,copy) NSNumber *cropHeight;
@property (nonatomic,copy) NSNumber *amount;
@end

@interface GLGetAttentionDynamicListResDynamicModel : NSObject
@property (nonatomic,copy) NSArray <GLGetAttentionDynamicListResMediaListModel *>*mediaList;
@property (nonatomic,copy) NSString *coverUrl;
@property (nonatomic,copy) NSString *entityType;
@property (nonatomic,copy) NSString *memberId;
@property (nonatomic,copy) NSString *memberName;
@property (nonatomic,copy) NSString *headerUrl;
@property (nonatomic,copy) NSString *caption;
@property (nonatomic,copy) NSString *reviewNum;
@property (nonatomic,copy) NSString *goodNum;
@property (nonatomic,copy) NSNumber *updateDate;
@property (nonatomic,copy) NSNumber *createDate;
@property (nonatomic,copy) NSNumber *type;
@property (nonatomic,copy) NSNumber *topicId;
@property (nonatomic,copy) NSNumber *laudStatus;
@property (nonatomic,copy) NSNumber *ID;
@end

@interface GLGetAttentionDynamicListResModel : NSObject
@property (nonatomic,copy) NSArray <GLGetAttentionDynamicListResDynamicModel *> *dynamic;
@property (nonatomic,copy) NSString *adSort;
@property (nonatomic,copy) NSNumber *hasAttentionDynamic;
@end

@interface GLGetDynamicListResponse : MXBaseResponse
@property (nonatomic,strong) GLGetAttentionDynamicListResModel *result;
@end
