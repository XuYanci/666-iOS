//
//  UIImageView+DYLYTheme.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "UIImageView+DYLYTheme.h"
#import <objc/runtime.h>

@interface UIImageView ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, DYLYColorPicker> *pickers;
@end


@implementation UIImageView (DYLYTheme)

- (instancetype)dyly_initWithImagePicker:(DYLYImagePicker)picker {
    UIImageView *imageView = [self initWithImage:picker(self.dyly_manager.currentTheme)];
    imageView.dyly_imagePicker = [picker copy];
    return imageView;
}

- (DYLYImagePicker )dyly_imagePicker {
    return objc_getAssociatedObject(self, @selector(dyly_imagePicker));
}

- (void)dyly_setImagePicker:(DYLYImagePicker)picker {
    objc_setAssociatedObject(self, @selector(dyly_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = picker(self.dyly_manager.currentTheme);
    [self.pickers setValue:[picker copy] forKey:@"setImage:"];
}

 
@end
