//
//  GLMediaBrowserViewController.h
//  66GoodLook
//
//  Created by Yanci on 17/4/28.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    GLAssetType_Picture,
    GLAssetType_Video,
    GLAssetType_Both,
} GLAssetType;


/*!
 @class GLMediaBrowserViewController
 @brief The UIViewController class
 @discussion   媒体库浏览器
 @superclass SuperClass: UIViewController\n
 @classdesign    No special design is applied here.
 @coclass    No coclass
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface GLAssetViewController : UIViewController
@property (nonatomic,assign) GLAssetType type;
@end
