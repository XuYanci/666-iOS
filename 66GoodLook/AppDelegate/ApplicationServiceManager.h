//
//  ApplicationServiceManager.h
//  66GoodLook
//
//  Created by Yanci on 17/4/9.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ApplicationService <UIApplicationDelegate>
@end

@interface ApplicationServiceManager :  UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
- (NSArray <ApplicationService>*)fillServices;
@end
