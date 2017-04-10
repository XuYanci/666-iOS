//
//  MXRequest.m
//  Maxer
//
//  Created by XuYanci on 15/4/29.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "MXRequest.h"
#import "MXNetworkConnection+BaseUrl.h"

@implementation MXRequest
+ (void)sendPostRequestWithMethod:(NSString *)method
                       parameters:(NSDictionary *)parameters
               beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                  SuccessCallBack:(SuccessCallback)successCallback
                    ErrorCallback:(ErrorCallback)errorCallback
                 CompleteCallback:(CompleteCallback)completeCallback {
    [MXNetworkConnection sendPostRequestWithMethod:method
                                        parameters:parameters
                                beforeSendCallback:beforeSendCallback
                                   SuccessCallBack:successCallback
                                     ErrorCallback:errorCallback
                                  CompleteCallback:completeCallback];
}

+ (void)sendGetRequestWithMethod:(NSString *)method  parameters:(NSDictionary *)parameters
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback {
    [MXNetworkConnection sendGetRequestWithMethod:method
                                       parameters:parameters
                               beforeSendCallback:beforeSendCallback
                                  SuccessCallBack:successCallback
                                    ErrorCallback:errorCallback
                                 CompleteCallback:completeCallback];
}
@end
