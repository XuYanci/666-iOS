//
//  DYLYColorTable.m
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/8.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "DYLYColorTable.h"

typedef NSString* DYLYTheme_;

@interface DYLYColorTable ()
@property (nonatomic,strong)NSMutableDictionary *table;
@end

@implementation DYLYColorTable

+ (DYLYColorTable *)sharedColorTable {
    static dispatch_once_t once;
    static DYLYColorTable *instance;
    dispatch_once(&once, ^{
        instance = [[DYLYColorTable alloc]init];
        instance.themePropertyFile = @"DYLYTheme.plist";
    });
    return instance;
}

- (void)reloadColorTable {
    self.table = nil;
    NSString *filePath = [[NSBundle mainBundle]pathForResource:self.themePropertyFile.stringByDeletingPathExtension
                                                        ofType:self.themePropertyFile.pathExtension];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    [self.table setDictionary:data];
}

- (void)setThemePropertyFile:(NSString *)themePropertyFile {
    _themePropertyFile = themePropertyFile;
    [self reloadColorTable];
}

#pragma mark - getter and setter
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (NSMutableDictionary *)table {
    if (!_table) {
        _table = [[NSMutableDictionary alloc]init];
    }
    return _table;
}

- (DYLYColorPicker)pickerWithKey:(NSString *)key {
    NSDictionary *themeToColorDictionary = [self.table valueForKey:key];
    DYLYColorPicker picker = ^(DYLYTheme_ themeVersion) {
        NSString *colorHexString = [themeToColorDictionary valueForKey:themeVersion];
        return [self colorFromHexString:colorHexString];
    };
    return picker;
}


@end
