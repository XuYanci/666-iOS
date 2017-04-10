//
//  DYLYColor.h
//  DYLYThemeManager
//
//  Created by Yanci on 16/4/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSString* _DYLYTheme;
typedef UIColor *(^DYLYColorPicker)(_DYLYTheme version);
@interface DYLYColor : NSObject

@end
