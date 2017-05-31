//
//  MXNetworkConnection.h
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "MXBaseUrl.h"
#import <YYKit/YYKit.h>

typedef enum : NSUInteger {
    MXRequestResultSuccess,
    MXRequestResultFail,
} MXRequestResult;

typedef void (^Callback)(NSInteger error,id result);
typedef void (^BeforeSendCallback)(void);
typedef void (^SuccessCallback)(id result);
typedef void (^ErrorCallback)(NSError *error);
typedef void (^CompleteCallback)(NSError *error, id result);



/**
 *  MXNetworkConnection
 *  @discussion 通过url发起Get,Post请求,返回格式为数据流。
 */
@interface MXNetworkConnection : NSObject

 
/**
 *  Send post request
 *  @note reponse utf8string
 *  @param url                url
 *  @param parameters         parameters description
 *  @param beforeSendCallback beforeSendCallback description
 *  @param successCallback    successCallback description
 *  @param errorCallback      errorCallback description
 *  @param completeCallback   completeCallback description
 */
+ (void)sendPostRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters
            beforeSendCallback:(BeforeSendCallback)beforeSendCallback
               SuccessCallBack:(SuccessCallback)successCallback
                 ErrorCallback:(ErrorCallback)errorCallback
              CompleteCallback:(CompleteCallback)completeCallback;

/**
 *  send get request
 *  @note  reponse utf8string
 *  @param url                url description
 *  @param parameters         parameters description
 *  @param beforeSendCallback beforeSendCallback description
 *  @param successCallback    successCallback description
 *  @param errorCallback      errorCallback description
 *  @param completeCallback   completeCallback description
 */
+ (void)sendGetRequestWithUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
           beforeSendCallback:(BeforeSendCallback)beforeSendCallback
              SuccessCallBack:(SuccessCallback)successCallback
                ErrorCallback:(ErrorCallback)errorCallback
             CompleteCallback:(CompleteCallback)completeCallback;


+ (void)sendPutRequestWithUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
           beforeSendCallback:(BeforeSendCallback)beforeSendCallback
              SuccessCallBack:(SuccessCallback)successCallback
                ErrorCallback:(ErrorCallback)errorCallback
             CompleteCallback:(CompleteCallback)completeCallback;

+ (void)sendDeleteRequestWithUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
           beforeSendCallback:(BeforeSendCallback)beforeSendCallback
              SuccessCallBack:(SuccessCallback)successCallback
                ErrorCallback:(ErrorCallback)errorCallback
             CompleteCallback:(CompleteCallback)completeCallback;


@end
