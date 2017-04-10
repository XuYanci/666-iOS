//
//  MXRequest+UserAccount.m
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "MXRequest+UserAccount.h"

@implementation MXRequest (UserAccount)

+ (void)sendUserLogin:(NSString *)customerUname customerPassword:(NSString *)customerPassword
       beforeCallback:(BeforeSendCallback)beforeCallback
      successCallback:(SuccessCallback)successCallback
        errorCallback:(ErrorCallback)errorCallback
     completeCallback:(CompleteCallback)completeCallback {
    NSMutableDictionary *dictonary = [NSMutableDictionary dictionary];
    [dictonary setObject:customerUname forKey:@"customerUname"];
    [dictonary setObject:customerPassword forKey:@"customerPassword"];
    [MXRequest sendPostRequestWithMethod:@"user_login" parameters:dictonary beforeSendCallback:beforeCallback SuccessCallBack:successCallback ErrorCallback:errorCallback CompleteCallback:completeCallback];
}

@end
