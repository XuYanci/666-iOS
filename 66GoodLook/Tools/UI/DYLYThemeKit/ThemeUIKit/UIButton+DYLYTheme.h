//
//  UIButton+DYLYThemem.h
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+DYLYTheme.h"

@interface UIButton (DYLYTheme)
- (void)dyly_setTitleColorPicker:(DYLYColorPicker)picker forState:(UIControlState)state;
- (void)dyly_setBackgroundImage:(DYLYImagePicker)picker forState:(UIControlState)state;
- (void)dyly_setImage:(DYLYImagePicker)picker forState:(UIControlState)state;
@end
