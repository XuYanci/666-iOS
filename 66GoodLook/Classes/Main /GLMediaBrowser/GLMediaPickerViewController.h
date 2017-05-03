//
//  GLMediaPickerViewController.h
//  66GoodLook
//
//  Created by Yanci on 17/5/3.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    GLMediaPickerType_Picture,
    GLMediaPickerType_Video,
} GLMediaPickerType;


/*!
 @class GLMediaPickerViewController
 @brief The UIViewController class
 @discussion   媒体库挑选器
 @superclass SuperClass: UIViewController\n
 @classdesign    No special design is applied here.
 @coclass    No coclass
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface GLMediaPickerViewController : UIViewController
@property (nonatomic,assign) GLMediaPickerType pickerType;

@end
