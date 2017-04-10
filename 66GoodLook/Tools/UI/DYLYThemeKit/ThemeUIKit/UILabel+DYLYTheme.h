//
//  UILabel+DYLYTheme.h
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+DYLYTheme.h"

@interface UILabel (DYLYTheme)
@property (nonatomic, copy, setter = dyly_setTextColorPicker:) DYLYColorPicker dyly_textColorPicker;
@end
