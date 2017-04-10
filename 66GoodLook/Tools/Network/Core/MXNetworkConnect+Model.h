//
//  MXNetworkConnect+Model.h
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXNetworkConnection.h"
#import "MXBaseRequest.h"
#import "MXBaseResponse.h"

 
typedef NS_ENUM(NSUInteger, ERRORHANDLENOTIFICATION) {
    ERRORHANDLENOTIFICATION_LOGINTIMEOUT,
};


/**
 *  MXNetworkConnection (Model)
 *  @discussion 通过method获取url进行post , get 请求,请求格式以及返回格式为Model。
 */
@interface MXNetworkConnection (Model)

/**
 Send post request
 @param method             method to url
 @param request            MXBaseRequest subclass
 @param beforeSendCallback request when before send callback
 @param successCallback request when success callback
 @param errorCallback request when error callback
 @param completeCallback request when complete callback
 */
+ (void)sendPostRequestWithMethod:(NSString *)method
                     requestModel:(MXBaseRequest *)request
                    responseClass:(Class)responseClass
               beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                  SuccessCallBack:(SuccessCallback)successCallback
                    ErrorCallback:(ErrorCallback)errorCallback
                 CompleteCallback:(CompleteCallback)completeCallback;

/**
 Send get request
 @param method             method to url
 @param request            MXBaseRequest subclass
 @param beforeSendCallback request when before send callback
 @param successCallback request when success callback
 @param errorCallback request when error callback
 @param completeCallback request when complete callback
 */
+ (void)sendGetRequestWithMethod:(NSString *)method
                    requestModel:(MXBaseRequest *)request
                   responseClass:(Class)responseClass
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback;



/**
 Send put request
 @note  TODO
 @param method method to url
 @param request MXBaseRequest subclass
 @param responseClass MXBaseResponse subclass
 @param beforeSendCallback request when before send callback
 @param successCallback request when success callback
 @param errorCallback request when error callback
 @param completeCallback request when complete callback
 */
+ (void)sendPutRequestWithMethod:(NSString *)method
                    requestModel:(MXBaseRequest *)request
                   responseClass:(Class)responseClass
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback;


/**
 Send delete request
 @note  TODO
 @param method method to url
 @param request MXBaseRequest subclass
 @param responseClass MXBaseResponse subclass
 @param beforeSendCallback request when before send callback
 @param successCallback request when success callback
 @param errorCallback request when error callback
 @param completeCallback request when complete callback
 */
+ (void)sendDeleteRequestWithMethod:(NSString *)method
                    requestModel:(MXBaseRequest *)request
                   responseClass:(Class)responseClass
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback;



/**
 Clear cache
 @param error error when clear cache
 */
+ (void)clearCache:(NSError **)error;


@end
