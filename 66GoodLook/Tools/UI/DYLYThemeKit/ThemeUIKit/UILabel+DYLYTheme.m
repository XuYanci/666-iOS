//
//  UILabel+DYLYTheme.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "UILabel+DYLYTheme.h"
#import <objc/runtime.h>

@interface UILabel ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, DYLYColorPicker> *pickers;
@end

@implementation UILabel (DYLYTheme)

- (DYLYColorPicker)dyly_textColorPicker {
    return objc_getAssociatedObject(self, @selector(dyly_textColorPicker));
}

- (void)dyly_setTextColorPicker:(DYLYColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dyly_textColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.textColor = picker(self.dyly_manager.currentTheme);
    [self.pickers setValue:[picker copy] forKey:@"setTextColor:"];
}

@end
