//
//  GLGetFineSelectionListResponse.h
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "MXBaseResponse.h"

@interface GLGetFineSelectionListResDynamicModel : NSObject
@property (nonatomic,copy) NSString *coverUrl;
@property (nonatomic,copy) NSArray <GLGetAttentionDynamicListResMediaListModel *>*mediaList;
@property (nonatomic,copy) NSNumber *entityType;
@property (nonatomic,copy) NSNumber *createDate;
@property (nonatomic,copy) NSString *caption;
@property (nonatomic,copy) NSNumber *goodNum;
@property (nonatomic,copy) NSNumber *type;
@property (nonatomic,copy) NSNumber *memberId;
@property (nonatomic,copy) NSString *memberName;
@property (nonatomic,copy) NSString *headerUrl;
@property (nonatomic,copy) NSString *ID;
@end


@interface GLGetFineSelectionListResActivityModel : NSObject
@property (nonatomic,copy) NSString *activityId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *shareUrl;
@property (nonatomic,copy) NSString *shareTitle;
@property (nonatomic,copy) NSString *shareSummary;
@property (nonatomic,copy) NSString *shareThumbnailUrl;
@property (nonatomic,copy) NSNumber *isNeedLogin;
@property (nonatomic,copy) NSNumber *restCount;
@property (nonatomic,copy) NSNumber *notifyType;
@end


@interface GLGetFineSelectionListResModel : NSObject
@property (nonatomic,copy) NSArray <GLGetFineSelectionListResDynamicModel *> *dynamic;
@property (nonatomic,copy) NSArray <GLGetFineSelectionListResActivityModel *> *activity;
@property (nonatomic,copy) NSString *adSort;
@property (nonatomic,copy) NSNumber *attentionTimestamp;
@property (nonatomic,copy) NSNumber *timestamp;
@end

@interface GLGetFineSelectionListResponse : MXBaseResponse
@property (nonatomic,strong)GLGetFineSelectionListResModel *result;
@end
