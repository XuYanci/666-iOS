//
//  UINavigationBar+DYLYTheme.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "UINavigationBar+DYLYTheme.h"
#import <objc/runtime.h>

@interface UINavigationBar()
@property (nonatomic,strong)NSMutableDictionary<NSString*,DYLYColorPicker> *pickers;
@end

@implementation UINavigationBar (DYLYTheme)

- (DYLYColorPicker)dyly_barTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dyly_barTintColorPicker));
}

- (DYLYColorPicker)dyly_tintColorPicker {
    return objc_getAssociatedObject(self, @selector(dyly_tintColorPicker));
}

- (void)dyly_setBarTintColorPicker:(DYLYColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dyly_barTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.barTintColor = picker(self.dyly_manager.currentTheme);
    [self.pickers setValue:[picker copy] forKey:@"setBarTintColor:"];
}

- (void)dyly_setTintColorPicker:(DYLYColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dyly_tintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tintColor = picker(self.dyly_manager.currentTheme);
    [self.pickers setValue:[picker copy] forKey:@"setTintColor:"];
}

@end
