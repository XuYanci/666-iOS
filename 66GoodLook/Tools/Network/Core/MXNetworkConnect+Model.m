//
//  MXNetworkConnect+Model.m
//  RoadShowLiveNetwork
//
//  Created by Yanci on 16/4/22.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "MXNetworkConnect+Model.h"
#import "MD5Encrypt.h"
 

@implementation MXNetworkConnection (Model)

/**
 *  Send post request
 *  @param method             method to url
 *  @param request            MXBaseRequest subclass
 *  @param beforeSendCallback beforeSendCallback description
 *  @param successCallback    successCallback description
 *  @param errorCallback      errorCallback description
 *  @param completeCallback   completeCallback description
 */
+ (void)sendPostRequestWithMethod:(NSString *)method
                     requestModel:(MXBaseRequest *)request
                    responseClass:(Class)responseClass
               beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                  SuccessCallBack:(SuccessCallback)successCallback
                    ErrorCallback:(ErrorCallback)errorCallback
                 CompleteCallback:(CompleteCallback)completeCallback {
    
    //Request -> Check CachePolicy & Check CacheTimeOutInteval -> Read Response Cache From Local Or Send Request -> Return Response to App Layer (Save to local or not)
    BOOL sendRequest = true;
    BOOL needCache = true;
    if (request.cachePolicy == MXRequestCachePolicyReloadIgnoringLocalCacheData) {
        sendRequest = true;
        needCache = false;
    }
    else if(request.cachePolicy == MXRequestCachePolicyReturnCacheDataElseLoad) {
        MXBaseResponse *cacheResponse = [self loadCacheResponseForRequest:[self cacheFileName:@"POST"
                                                                                       apiUrl:[MXBaseUrl baseUrl:method]request:request]
                                                            responseClass:responseClass];
        NSUInteger timeInterval = [cacheResponse.cacheDate timeIntervalSinceNow];
        sendRequest = (!cacheResponse || timeInterval > request.cacheTimeOutInterval) ? true : false;
        needCache = true;
    }
    
    if (!sendRequest) {
        MXBaseResponse *cacheResponse = [self loadCacheResponseForRequest:[self cacheFileName:@"POST"
                                                                                       apiUrl:[MXBaseUrl baseUrl:method]request:request]
                                                            responseClass:responseClass];
        beforeSendCallback();
        successCallback(cacheResponse);
        completeCallback(nil,
                         cacheResponse);
        needCache = false;
        return;
    }
    
    NSDictionary *parameters = [request yy_modelToJSONObject];
    [self sendPostRequestWithUrl:[MXBaseUrl baseUrl:method]
                      parameters:parameters
              beforeSendCallback:beforeSendCallback
                 SuccessCallBack:^(id result) {

                     if (successCallback) {
                         MXBaseResponse *response = [responseClass yy_modelWithJSON:result];
                        
                         successCallback(response);
                         if (needCache) {
                             [self cacheResponseForRequest:[self cacheFileName:@"POST"
                                                                        apiUrl:[MXBaseUrl baseUrl:method]request:request]
                                                  response:response];
                         }
                     }
                 }
                ErrorCallback:^(NSError *error) {
                    if (errorCallback) {
                
                        errorCallback(error);
                    }
                }
                CompleteCallback:^(NSError *error, id result) {
                    if (completeCallback) {
                        MXBaseResponse *response = [responseClass yy_modelWithJSON:result];
                        completeCallback(error,
                                         response);
                    }
                }];
}

+ (void)sendGetRequestWithMethod:(NSString *)method
                    requestModel:(MXBaseRequest *)request
                   responseClass:(Class)responseClass
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback {
    
    //Request -> Check CachePolicy & Check CacheTimeOutInteval -> Read Response Cache From Local Or Send Request -> Return Response to App Layer (Save to local or not)
    BOOL sendRequest = true;
    BOOL needCache = true;
    if (request.cachePolicy == MXRequestCachePolicyReloadIgnoringLocalCacheData) {
        sendRequest = true;
        needCache = false;
    }
    else if(request.cachePolicy == MXRequestCachePolicyReturnCacheDataElseLoad) {
        MXBaseResponse *cacheResponse = [self loadCacheResponseForRequest:[self cacheFileName:@"GET"
                                                                                       apiUrl:[MXBaseUrl baseUrl:method]request:request]
                                                            responseClass:responseClass];
        NSUInteger timeInterval = [cacheResponse.cacheDate timeIntervalSinceNow];
        sendRequest = (!cacheResponse || timeInterval > request.cacheTimeOutInterval) ? true : false;
        needCache = true;
    }
    
    
    if (!sendRequest) {
        MXBaseResponse *cacheResponse = [self loadCacheResponseForRequest:[self cacheFileName:@"GET"
                                                                                       apiUrl:[MXBaseUrl baseUrl:method]request:request]
                                                            responseClass:responseClass];
        beforeSendCallback();
        successCallback(cacheResponse);
        completeCallback(nil,
                         cacheResponse);
        needCache = false;
        return;
    }
    
    
    NSDictionary *parameters = [request yy_modelToJSONObject];
    [self sendGetRequestWithUrl:[MXBaseUrl baseUrl:method]
                     parameters:parameters
             beforeSendCallback:beforeSendCallback
                SuccessCallBack:^(id result)
     {
         if (successCallback) {
             MXBaseResponse *response = [responseClass yy_modelWithJSON:result];
            
             successCallback(response);
             if (needCache) {
                 [self cacheResponseForRequest:[self cacheFileName:@"GET"
                                                            apiUrl:[MXBaseUrl baseUrl:method]request:request]
                                      response:response];
             }
         }
     }
      ErrorCallback:^(NSError *error) {
          if (errorCallback) {
              errorCallback(error);
          }
      }
     CompleteCallback:^(NSError *error, id result)
     {
         if (completeCallback) {
             MXBaseResponse *response = [responseClass yy_modelWithJSON:result];
             completeCallback(error,
                              response);
         }
     }];
    
}

+ (void)sendPutRequestWithMethod:(NSString *)method
                    requestModel:(MXBaseRequest *)request
                   responseClass:(Class)responseClass
              beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                 SuccessCallBack:(SuccessCallback)successCallback
                   ErrorCallback:(ErrorCallback)errorCallback
                CompleteCallback:(CompleteCallback)completeCallback {}

+ (void)sendDeleteRequestWithMethod:(NSString *)method
                       requestModel:(MXBaseRequest *)request
                      responseClass:(Class)responseClass
                 beforeSendCallback:(BeforeSendCallback)beforeSendCallback
                    SuccessCallBack:(SuccessCallback)successCallback
                      ErrorCallback:(ErrorCallback)errorCallback
                   CompleteCallback:(CompleteCallback)completeCallback {}

// 缓存目录路径
+ (NSString *)cacheBasePath {
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"LazyModelRequestCache"];
    [self checkDirectory:path];
    return path;
}

/**
 *  @brief 获取缓存文件名称
 *  @param requestMethod 请求方法
 *  @param apiUrl        请求完整url
 *  @param request       请求Model
 *  @return 缓存文件名称
 */
+ (NSString *)cacheFileName:(NSString *)requestMethod
                     apiUrl:(NSString *)apiUrl
                    request:(MXBaseRequest *)request {
    NSDictionary *parameters = [request yy_modelToJSONObject];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%@ apiUrl:%@ Argument:%@ AppVersion:%@",requestMethod,apiUrl,parameters,app_Version];
    return [MD5Encrypt md532BitLower:requestInfo];
}

+ (void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        NSLog(@"create cache directory failed, error = %@", error);
    } else {
        
    }
}

// 缓存Response
+ (void)cacheResponseForRequest:(NSString *)cacheFileName response:(MXBaseResponse *)response{
    NSString *cacheFullPath = [self cacheBasePath];
    cacheFullPath = [cacheFullPath stringByAppendingString:@"/"];
    cacheFullPath = [cacheFullPath stringByAppendingString:cacheFileName];
    [[response yy_modelToJSONString]writeToFile:cacheFullPath atomically:true encoding:NSUnicodeStringEncoding error:nil];
}

// 读取Response
+ (MXBaseResponse *)loadCacheResponseForRequest:(NSString *)cacheFileName responseClass:(Class)responseClass {
    NSString *cacheFullPath = [self cacheBasePath];
    cacheFullPath = [cacheFullPath stringByAppendingString:@"/"];
    cacheFullPath = [cacheFullPath stringByAppendingString:cacheFileName];
    NSString *cacheJsonString = [NSString stringWithContentsOfFile:cacheFullPath encoding:NSUnicodeStringEncoding error:nil];
    return [[responseClass class] yy_modelWithJSON:cacheJsonString];
}

+ (void)clearCache:(NSError *__autoreleasing *)error {
    [[NSFileManager defaultManager]removeItemAtPath:[self cacheBasePath] error:error];
}

@end
