//
//  DYLYThemeManager.h
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DYLYColor.h"
#import "DYLYImage.h"


/*!
 @class DYLYThemeManager
 @brief The NSObject class
 @discussion   主题管理器,用于存取主题以及通知控件修改颜色
 @superclass SuperClass: NSObject\n
 @classdesign    Single Pattern
 @coclass    AppDelegate
 @helps It helps no other classes.
 @helper    No helper exists for this class.
*/


extern NSString* const DYLYThemeChangingNotification;       /*! 主题更换通知 */
extern NSString* const DYLYThemeCurrentThemeKey;            /*! 主题UserDefault存储Key */
extern CGFloat const DYLYThemeAnimationDuration;            /*! 主题切换间隔时间 */

/*! 主题样式 */
extern NSString *const DYLYThemeDay;
extern NSString *const DYLYThemeNight;
extern NSString *const DYLYThemeOthers;


@interface DYLYThemeManager : NSObject
@property (nonatomic,strong) NSString* currentTheme; /*! 设置当前样式 */
+ (DYLYThemeManager *)shareThemeManager;
@end
