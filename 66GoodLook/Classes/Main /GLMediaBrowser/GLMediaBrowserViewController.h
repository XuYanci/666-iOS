//
//  GLMediaBrowserViewController.h
//  66GoodLook
//
//  Created by Yanci on 17/4/28.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    GLMediaBrowserType_Picture,
    GLMediaBrowserType_Video,
    GLMediaBrowserType_Both,
} GLMediaBrowserType;

@interface GLMediaBrowserViewController : UIViewController
@property (nonatomic,assign) GLMediaBrowserType type;
@end
