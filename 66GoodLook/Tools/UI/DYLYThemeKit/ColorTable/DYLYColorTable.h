//
//  DYLYColorTable.h
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/8.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DYLYTheme.h"

#define DYLYColorPickerWithKey(key) [[DYLYColorTable sharedColorTable] pickerWithKey:key]

@interface DYLYColorTable : NSObject
@property (nonatomic,strong) NSString *themePropertyFile;

/*! 单例返回 */
+ (DYLYColorTable *)sharedColorTable;

/**
 *  @brief It reads color table from property path (DYLYTheme.plist)
 *  @discussion It contains structure like <COLOR_KEY,  DICT<THEME,COLOR>>
 */
- (void)reloadColorTable;

/**
 *  @brief It return color picker with color key
 *  @param key color key in theme plist file
 *  @return color picker
 */
- (DYLYColorPicker)pickerWithKey:(NSString *)key;
@end
