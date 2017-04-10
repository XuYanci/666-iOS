//
//  DYLYThemeManager.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "DYLYThemeManager.h"

NSString* const DYLYThemeChangingNotification = @"DYLYThemeChangingNotification";
NSString* const DYLYThemeCurrentThemeKey = @"com.dyly.theme.currenttheme";
CGFloat const DYLYThemeAnimationDuration = 0.3;

NSString *const DYLYThemeDay = @"dyly.theme.day";
NSString *const DYLYThemeNight = @"dyly.theme.night";
NSString *const DYLYThemeOthers = @"dyly.theme.others";


@implementation DYLYThemeManager

+ (id)shareThemeManager {
    static dispatch_once_t once;
    static DYLYThemeManager *instance;
    dispatch_once(&once, ^{
        instance = [[DYLYThemeManager alloc]init];
        NSString *currentTheme = [[NSUserDefaults standardUserDefaults]objectForKey:DYLYThemeCurrentThemeKey];
        /*! Default theme is DYLYTheme_Day */
        if (currentTheme == nil) {
            currentTheme = DYLYThemeDay;
        }
        instance.currentTheme = currentTheme;
    
    });
    return instance;
}

- (void)setCurrentTheme:(NSString *)currentTheme {
    if (self.currentTheme == currentTheme) {
        return;
    }
    _currentTheme = currentTheme;
    
    /*! Save theme */
    [[NSUserDefaults standardUserDefaults]setObject:currentTheme forKey:DYLYThemeCurrentThemeKey];
    [[NSUserDefaults standardUserDefaults]synchronize];

    /*! Dispatch Message & Notify Changing */
    [[NSNotificationCenter defaultCenter]postNotificationName:DYLYThemeChangingNotification object:nil];
}



@end
