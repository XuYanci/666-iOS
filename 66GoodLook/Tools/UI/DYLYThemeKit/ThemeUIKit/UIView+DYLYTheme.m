//
//  UIView+DYLYTheme.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "UIView+DYLYTheme.h"
#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic,strong)NSMutableDictionary <NSString*,DYLYColorPicker> *pickers;
@end

@implementation UIView (DYLYTheme)

- (DYLYColorPicker )dyly_backgroundColorPicker {
    return objc_getAssociatedObject(self, @selector(dyly_backgroundColorPicker));
}

- (DYLYColorPicker)dyly_tintColorPicker {
    return objc_getAssociatedObject(self, @selector(dyly_tintColorPicker));
}

- (void)dyly_setBackgroundColorPicker:(DYLYColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dyly_backgroundColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.backgroundColor = picker(self.dyly_manager.currentTheme);
    [self.pickers setValue:[picker copy] forKey:@"setBackgroundColor:"];
}

- (void)dyly_setTintColorPicker:(DYLYColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dyly_tintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tintColor = picker(self.dyly_manager.currentTheme);
    [self.pickers setValue:[picker copy] forKey:@"setTintColor:"];
}


@end
