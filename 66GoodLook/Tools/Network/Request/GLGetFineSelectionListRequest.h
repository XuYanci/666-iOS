//
//  GLGetFineSelectionListRequest.h
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "MXBaseRequest.h"

@interface GLGetFineSelectionListRequest : MXBaseRequest
@property (nonatomic,strong) NSString *attentionTimestamp;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *adSort;
@end
