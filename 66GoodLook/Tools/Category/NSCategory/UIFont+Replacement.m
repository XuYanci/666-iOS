//
//  UIFont+Replacement.m
//  Maxer
//
//  Created by XuYanci on 15/8/18.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "UIFont+Replacement.h"
#import <objc/runtime.h>


NSString *const FORegularFontName = @"PingFangSC-Regular";      /*! 需要设置的字体在此设置, 定义App Regular字体 */
NSString *const FOBoldFontName = @"PingFangSC-Medium";         /*! 需要设置的字体在此设置, 定义App Bold字体 */
NSString *const FOItalicFontName = @"PingFangSC-Light";         /*! 需要设置的字体在此设置, 定义App Light字体 */
NSString *const FOLightFontName = @"PingFangSC-Light";          /**  需要设置的字体在此设置, 定义App Light字体 */


@implementation UIFont (Replacement)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (void)replaceClassSelector:(SEL)originalSelector withSelector:(SEL)modifiedSelector {
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method modifiedMethod = class_getClassMethod(self, modifiedSelector);
    method_exchangeImplementations(originalMethod, modifiedMethod);
}

+ (void)replaceInstanceSelector:(SEL)originalSelector withSelector:(SEL)modifiedSelector {
    Method originalDecoderMethod = class_getInstanceMethod(self, originalSelector);
    Method modifiedDecoderMethod = class_getInstanceMethod(self, modifiedSelector);
    method_exchangeImplementations(originalDecoderMethod, modifiedDecoderMethod);
}

+ (BOOL)isExistPingFangTC {
    BOOL exist = false;
    for (NSString *fontName in [UIFont familyNames]) {
        if ([fontName rangeOfString:@"PingFang SC"].length > 0) {
            exist = true;
            break;
        }
        else
            continue;
    }
    return exist;
}

+ (UIFont *)regularFontWithSize:(CGFloat)size
{
    if ([self isExistPingFangTC]) {
        return [UIFont fontWithName:FORegularFontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)boldFontWithSize:(CGFloat)size
{
    if ([self isExistPingFangTC]) {
        return [UIFont fontWithName:FOBoldFontName size:size];
    }
    return [UIFont boldSystemFontOfSize:size];
}

+ (UIFont *)italicFontOfSize:(CGFloat)fontSize
{
    if ([self isExistPingFangTC]) {
        return [UIFont fontWithName:FOItalicFontName size:fontSize];
    }
    return [UIFont italicSystemFontOfSize:fontSize];
}

- (id)initCustomWithCoder:(NSCoder *)aDecoder {
    BOOL result = [aDecoder containsValueForKey:@"UIFontDescriptor"];
    
    if (result) {
        UIFontDescriptor *descriptor = [aDecoder decodeObjectForKey:@"UIFontDescriptor"];
        
        NSString *fontName;
        if ([descriptor.fontAttributes[@"NSCTFontUIUsageAttribute"] isEqualToString:@"CTFontRegularUsage"]) {
            fontName = FORegularFontName;
        }
        else if ([descriptor.fontAttributes[@"NSCTFontUIUsageAttribute"] isEqualToString:@"CTFontEmphasizedUsage"]) {
            fontName = FOBoldFontName;
        }
        else if ([descriptor.fontAttributes[@"NSCTFontUIUsageAttribute"] isEqualToString:@"CTFontObliqueUsage"]) {
            fontName = FOItalicFontName;
        }
        else {
            fontName = descriptor.fontAttributes[@"NSFontNameAttribute"];
        }
        
        return [UIFont fontWithName:fontName size:descriptor.pointSize];
    }
    
    self = [self initCustomWithCoder:aDecoder];
    
    return self;
}

+ (void)load
{
    if ([self isExistPingFangTC]) {
        [self replaceClassSelector:@selector(systemFontOfSize:) withSelector:@selector(regularFontWithSize:)];
        [self replaceClassSelector:@selector(boldSystemFontOfSize:) withSelector:@selector(boldFontWithSize:)];
        [self replaceClassSelector:@selector(italicSystemFontOfSize:) withSelector:@selector(italicFontOfSize:)];
        [self replaceInstanceSelector:@selector(initWithCoder:) withSelector:@selector(initCustomWithCoder:)];
    }
}
#pragma clang diagnostic pop
 
@end
