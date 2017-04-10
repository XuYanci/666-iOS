//
//  MXRequest.h
//  Maxer
//
//  Created by XuYanci on 15/4/29.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXNetworkConnection.h"


@interface MXRequest : NSObject
+ (void)sendPostRequestWithMethod:(NSString *)method
                       parameters:(NSDictionary *)parameters
               beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                  SuccessCallBack:(SuccessCallback)successCallback
                    ErrorCallback:(ErrorCallback)errorCallback
                 CompleteCallback:(CompleteCallback)completeCallback;

+ (void)sendGetRequestWithMethod:(NSString *)method  parameters:(NSDictionary *)parameters
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback;
@end
