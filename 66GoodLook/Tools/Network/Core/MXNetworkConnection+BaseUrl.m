//
//  MXNetworkConnection+BaseUrl.m
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "MXNetworkConnection+BaseUrl.h"

@implementation MXNetworkConnection (BaseUrl)

+ (void)sendPostRequestWithMethod:(NSString *)method
                       parameters:(NSDictionary *)parameters
               beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                  SuccessCallBack:(SuccessCallback)successCallback
                    ErrorCallback:(ErrorCallback)errorCallback
                 CompleteCallback:(CompleteCallback)completeCallback {
    
    [self sendPostRequestWithUrl:[MXBaseUrl baseUrl:method] parameters:parameters beforeSendCallback:beforeSendCallback SuccessCallBack:^(id result) {
        if (successCallback) {
            successCallback( result);
        }
    }  ErrorCallback:errorCallback CompleteCallback:^(NSError *error, id result) {
        
        if (completeCallback) {
            completeCallback(error,result);
        }
    }];
}

+ (void)sendGetRequestWithMethod:(NSString *)method
                      parameters:(NSDictionary *)parameters
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback {
    [self sendGetRequestWithUrl:[MXBaseUrl baseUrl:method] parameters:parameters beforeSendCallback:beforeSendCallback SuccessCallBack:^(id result) {
        
        if (successCallback) {
            successCallback( result);
        }
    }  ErrorCallback:errorCallback CompleteCallback:^(NSError *error, id result) {
        
        
        if (completeCallback) {
            completeCallback(error,result);
        }
    }];
}

@end
