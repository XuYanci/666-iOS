//
//  UIImageView+DYLYTheme.h
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+DYLYTheme.h"

@interface UIImageView (DYLYTheme)
- (instancetype)dyly_initWithImagePicker:(DYLYImagePicker)picker;
@property (nonatomic, copy, setter = dyly_setImagePicker:) DYLYImagePicker dyly_imagePicker;
@end
