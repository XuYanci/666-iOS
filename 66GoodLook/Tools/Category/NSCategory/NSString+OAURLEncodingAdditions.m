//
//  NSString+OAURLEncodingAdditions.m
//  Maxer
//
//  Created by XuYanci on 15/4/30.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "NSString+OAURLEncodingAdditions.h"

@implementation NSString (OAURLEncodingAdditions)
- (NSString *)URLEncodedString {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED  >= __IPHONE_9_0
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self,(CFStringRef)@"!*'();:@&=+$,/?%#[]"));
        return result;
    }
    else {
        NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
        return result;
    }
#else
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return result;
#endif
}

- (NSString *)URLDecodedString {
#if __IPHONE_OS_VERSION_MAX_ALLOWED  >= __IPHONE_9_0
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        NSString *result =  (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL));
        return result;
    }
    else {
        NSString *result =  (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL,  kCFStringEncodingUTF8));
        return result;

    }
#else
    NSString *result =  (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL,  kCFStringEncodingUTF8));
    return result;

#endif
    
  
}
@end
