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
    
    /** This will cause off-screen */
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:254.0/255.0
                                                                 green:206.0/255.0
                                                                  blue:0.0
                                                                 alpha:1.0]];
    
  
    
    return YES;
}

@end
