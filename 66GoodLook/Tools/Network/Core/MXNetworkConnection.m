//
//  MXNetworkConnection.m
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "MXNetworkConnection.h"
 

@implementation MXNetworkConnection

 

+ (void)sendPostRequestWithUrl:(NSString *)url
                    parameters:(NSDictionary *)parameters
            beforeSendCallback:(BeforeSendCallback)beforeSendCallback
               SuccessCallBack:(SuccessCallback)successCallback
                 ErrorCallback:(ErrorCallback)errorCallback
              CompleteCallback:(CompleteCallback)completeCallback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    /*! Config request & response */
    [manager.requestSerializer setTimeoutInterval:DYLY_REQUEST_TIMEOUT];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json", nil];
    
    if (beforeSendCallback) {
        beforeSendCallback();
    }

    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (successCallback) {
             successCallback(responseObject);
        }
       
        if (completeCallback) {
            completeCallback(nil,responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (errorCallback) {
            errorCallback(error);
        }
        if (completeCallback) {
            completeCallback(error,nil);
        }
    }];
    
}

+ (void)sendGetRequestWithUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
           beforeSendCallback:(BeforeSendCallback)beforeSendCallback
              SuccessCallBack:(SuccessCallback)successCallback
                ErrorCallback:(ErrorCallback)errorCallback
             CompleteCallback:(CompleteCallback)completeCallback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:DYLY_REQUEST_TIMEOUT];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain", nil];
    if (beforeSendCallback) {
         beforeSendCallback();
    }   
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (successCallback) {
            successCallback(responseObject);
        }
        if (completeCallback) {
            completeCallback(nil,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (errorCallback) {
            errorCallback(error);
        }
        if (completeCallback) {
            completeCallback(error,nil);
        }
    }];
}

+ (void)sendPutRequestWithUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
           beforeSendCallback:(BeforeSendCallback)beforeSendCallback
              SuccessCallBack:(SuccessCallback)successCallback
                ErrorCallback:(ErrorCallback)errorCallback
             CompleteCallback:(CompleteCallback)completeCallback {

}

+ (void)sendDeleteRequestWithUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback {

}


@end
