//
//  UIFont+Replacement.h
//  Maxer
//
//  Created by XuYanci on 15/8/18.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const FORegularFontName ;      /*! 需要设置的字体在此设置, 定义App Regular字体 */
extern NSString *const FOBoldFontName;          /*! 需要设置的字体在此设置, 定义App Bold字体 */
extern NSString *const FOItalicFontName ;       /*! 需要设置的字体在此设置, 定义App Light字体 */
extern NSString *const FOLightFontName  ;      /*! 需要设置的字体在此设置, 定义App Light字体 */

@interface UIFont (Replacement)
+ (BOOL)isExistPingFangTC;  /*! 是否存在PingFangTC该字体 */
@end
