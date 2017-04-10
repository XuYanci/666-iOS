//
//  UIView+DYLYTheme.h
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+DYLYTheme.h"

@interface UIView (DYLYTheme)
@property (nonatomic, copy, setter = dyly_setBackgroundColorPicker:) DYLYColorPicker dyly_backgroundColorPicker;
@property (nonatomic, copy, setter = dyly_setTintColorPicker:) DYLYColorPicker dyly_tintColorPicker;

@end
