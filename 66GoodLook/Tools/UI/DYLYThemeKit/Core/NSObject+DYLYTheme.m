//
//  NSObject+DYLYTheme.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "NSObject+DYLYTheme.h"
#import "DYLYThemeManager.h"
#import "DYLYColor.h"
#import <objc/runtime.h>
#import "NSObject+DeallocBlock.h"

static void *DYLYViewDeallocHelperKey;

@interface NSObject ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, DYLYColorPicker> *pickers;
@end

@implementation NSObject (DYLYTheme)

- (NSMutableDictionary<NSString *, DYLYColorPicker> *)pickers {
    NSMutableDictionary<NSString *, DYLYColorPicker> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        
        @autoreleasepool {
            // Need to removeObserver in dealloc
            if (objc_getAssociatedObject(self, &DYLYViewDeallocHelperKey) == nil) {
                __unsafe_unretained typeof(self) weakSelf = self; // NOTE: need to be __unsafe_unretained because __weak var will be reset to nil in dealloc
                id deallocHelper = [self addDeallocBlock:^{
                    [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
                }];
                objc_setAssociatedObject(self, &DYLYViewDeallocHelperKey, deallocHelper, OBJC_ASSOCIATION_ASSIGN);
            }
        }
        
        pickers = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:DYLYThemeChangingNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(change_dyly_theme)
                                                     name:DYLYThemeChangingNotification
                                                   object:nil];
    }
    return pickers;
}

- (DYLYThemeManager *)dyly_manager {
    return [DYLYThemeManager shareThemeManager];
}

- (void)change_dyly_theme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector,
                                                      DYLYColorPicker  _Nonnull picker,
                                                      BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(selector);
        id result = picker(self.dyly_manager.currentTheme);
        [UIView animateWithDuration:DYLYThemeAnimationDuration
                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [self performSelector:sel withObject:result];
#pragma clang diagnostic pop
                         }];
        
    }];
}


@end
