//
//  MXRequest+UserAccount.h
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRequest.h"



@interface MXRequest (UserAccount)
+ (void)sendUserLogin:(NSString *)customerUname
     customerPassword:(NSString *)customerPassword
       beforeCallback:(BeforeSendCallback)beforeCallback
      successCallback:(SuccessCallback)successCallback
        errorCallback:(ErrorCallback)errorCallback
     completeCallback:(CompleteCallback)completeCallback;
@end
