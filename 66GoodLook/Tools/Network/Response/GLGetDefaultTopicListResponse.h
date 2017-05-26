//
//  GLGetDefaultTopicListResponse.h
//  666
//
//  Created by Yanci on 17/5/26.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "MXBaseResponse.h"

@interface GLGetDefaultTopicListModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSNumber *type;
@property (nonatomic,strong) NSNumber *ID;
@end

@interface GLGetDefaultTopicListResponse : MXBaseResponse
@property (nonatomic,strong)NSArray <GLGetDefaultTopicListModel *> *result;
@end
