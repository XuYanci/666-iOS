//
//  XYMacroUtility.h
//  66GoodLook
//
//  Created by Yanci on 17/4/10.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#ifndef XYMacroUtility_h
#define XYMacroUtility_h


// App 系统比较
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// App 版本比较
#define APP_VERSION_EQUAL_TO(v) ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]compare:v options:NSNumericSearch] == NSOrderedSame)
#define APP_VERSION_GREATER_THAN(v) ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]compare:v options:NSNumericSearch] == NSOrderedDescending)
#define APP_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]compare:v options:NSNumericSearch] != NSOrderedAscending)
#define APP_VERSION_LESS_THAN(v) ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]compare:v options:NSNumericSearch] == NSOrderedAscending)
#define APP_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]compare:v options:NSNumericSearch] != NSOrderedDescending)

// App 适配
#define DEVICE_TYPE_IPAD  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#endif /* XYMacroUtility_h */
