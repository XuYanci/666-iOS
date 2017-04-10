//
//  NSString+JSONCategories.m
//  Maxer
//
//  Created by XuYanci on 15/4/30.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "NSString+JSONCategories.h"
@implementation NSString (JSONCategories)
-(id)JSONValue {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
