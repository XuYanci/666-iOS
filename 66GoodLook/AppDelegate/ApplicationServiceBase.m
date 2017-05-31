//
//  ApplicationServiceBase.m
//  66GoodLook
//
//  Created by Yanci on 17/4/9.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "ApplicationServiceBase.h"
#import "YYFPSLabel.h"
@implementation ApplicationServiceBase

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    /** Add fps label */
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - 30.0 + 80.0, 0, 60, 20)];
    fpsLabel.backgroundColor = [UIColor greenColor];
    [[UIApplication sharedApplication].keyWindow addSubview:fpsLabel];
    
    
    return YES;
}

@end
