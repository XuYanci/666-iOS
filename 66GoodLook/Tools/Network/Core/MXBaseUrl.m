//
//  MXBaseUrl.m
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "MXBaseUrl.h"

@implementation MXBaseUrl


+ (NSDictionary *)UrlMethodMapper {
    return @{
                @"getDefaultTopicList": MAXER_URL_LINK(MAXER_URL_PREFIX, @"/home/getDefaultTopicList"),
                @"getAttentionDynamicList": MAXER_URL_LINK(MAXER_URL_PREFIX, @"/home/getAttentionDynamicList"),
                @"getDynamicList":MAXER_URL_LINK(MAXER_URL_PREFIX, @"/home/getDynamicList"),
                @"getFineSelectionList":MAXER_URL_LINK(MAXER_URL_PREFIX, @"/home/getFineSelectionList"),
             };
}

+ (NSString *)baseUrl:(NSString *)method {
    NSString *url = [[self UrlMethodMapper]objectForKey:method];
    return url;
}

+ (NSString *)baseUrlWithParams:(NSString *)method params:(NSDictionary *)params {
    __block NSString *url = [[self UrlMethodMapper]objectForKey:method];
    
    BOOL isFirstParam = true;
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (isFirstParam) {
            url = [url stringByAppendingFormat:@"?%@=%@",(NSString *)key,obj];
        }
        else
            url = [url stringByAppendingFormat:@"&%@=%@",(NSString *)key,obj];
    }];
    return url;
}


@end
