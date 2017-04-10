//
//  UIButton+DYLYThemem.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "UIButton+DYLYTheme.h"
#import <objc/runtime.h>

@interface UIButton ()
@property (nonatomic,strong)NSMutableDictionary <NSString *,id> *pickers;
@end

@implementation UIButton (DYLYTheme)

- (void)dyly_setTitleColorPicker:(DYLYColorPicker)picker forState:(UIControlState)state {
    [self setTitleColor:picker(self.dyly_manager.currentTheme) forState:state];
    NSString *key = [NSString stringWithFormat:@"%@",@(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    [dictionary setValue:[picker copy] forKey:NSStringFromSelector(@selector(setTitleColor:forState:))];
    [self.pickers setValue:dictionary forKey:key];
}

- (void)dyly_setBackgroundImage:(DYLYImagePicker)picker forState:(UIControlState)state {
    [self setBackgroundImage:picker(self.dyly_manager.currentTheme) forState:state];
    NSString *key = [NSString stringWithFormat:@"%@",@(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    [dictionary setValue:[picker copy] forKey:NSStringFromSelector(@selector(setBackgroundImage:forState:))];
    [self.pickers setValue:dictionary forKey:key];
}

- (void)dyly_setImage:(DYLYImagePicker)picker forState:(UIControlState)state {
    [self setImage:picker(self.dyly_manager.currentTheme) forState:state];
    NSString *key = [NSString stringWithFormat:@"%@",@(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    [dictionary setValue:[picker copy] forKey:NSStringFromSelector(@selector(setImage:forState:))];
    [self.pickers setValue:dictionary forKey:key];
}

- (void)change_dyly_theme {
    
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        /**
         *  Dictionary structure  <STATE, <SELECTOR,PICKER>>
         */
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, DYLYColorPicker> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DYLYColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
                UIControlState state = [key integerValue];
                [UIView animateWithDuration:DYLYThemeAnimationDuration
                                 animations:^{
                                     if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleColor:forState:))]) {
                                         UIColor *resultColor = picker(self.dyly_manager.currentTheme);
                                         [self setTitleColor:resultColor forState:state];
                                     } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundImage:forState:))]) {
                                         UIImage *resultImage = ((DYLYImagePicker)picker)(self.dyly_manager.currentTheme);
                                         [self setBackgroundImage:resultImage forState:state];
                                     } else if ([selector isEqualToString:NSStringFromSelector(@selector(setImage:forState:))]) {
                                         UIImage *resultImage = ((DYLYImagePicker)picker)(self.dyly_manager.currentTheme);
                                         [self setImage:resultImage forState:state];
                                     }
                                 }];
            }];
        } else {
            SEL sel = NSSelectorFromString(key);
            DYLYColorPicker picker = (DYLYColorPicker)obj;
            UIColor *resultColor = picker(self.dyly_manager.currentTheme);
            [UIView animateWithDuration:DYLYThemeAnimationDuration
                             animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                 [self performSelector:sel withObject:resultColor];
#pragma clang diagnostic pop
                             }];
            
        }
    }];
}

@end
