//
//  ApplicationServiceBase.m
//  66GoodLook
//
//  Created by Yanci on 17/4/9.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "ApplicationServiceBase.h"

@implementation ApplicationServiceBase

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    GLGetFineSelectionListRequest *request = [[GLGetFineSelectionListRequest alloc]init];
    [MXNetworkConnection sendGetRequestWithMethod:@"getFineSelectionList"
                                     requestModel:request
                                    responseClass:[GLGetFineSelectionListResponse class] beforeSendCallback:^{
        
    } SuccessCallBack:^(id result) {
        
    } ErrorCallback:^(NSError *error) {
        
    } CompleteCallback:^(NSError *error, id result) {
        
    }];
    
    return YES;
}

@end
