//
//  MXNetworkConnection+BaseUrl.h
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXNetworkConnection.h"


/**
 *  MXNetworkConnection (BaseUrl)
 *  @discussion 通过method获取对应的url发起Post,Get请求,返回格式解析为JSON格式
 */
@interface MXNetworkConnection (BaseUrl)
/**
 *  Send post request
 *  @note  response json format
 *  @param method             method to url
 *  @param parameters         parameters description
 *  @param beforeSendCallback beforeSendCallback description
 *  @param successCallback    successCallback description
 *  @param errorCallback      errorCallback description
 *  @param completeCallback   completeCallback description
 */
+ (void)sendPostRequestWithMethod:(NSString *)method
                       parameters:(NSDictionary *)parameters
               beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                  SuccessCallBack:(SuccessCallback)successCallback
                    ErrorCallback:(ErrorCallback)errorCallback
                 CompleteCallback:(CompleteCallback)completeCallback;

/**
 *  Send get request
 *  @note  response json format
 *  @param method             method to url
 *  @param parameters         parameters description
 *  @param beforeSendCallback beforeSendCallback description
 *  @param successCallback    successCallback description
 *  @param errorCallback      errorCallback description
 *  @param completeCallback   completeCallback description
 */
+ (void)sendGetRequestWithMethod:(NSString *)method  parameters:(NSDictionary *)parameters
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback;



@end
