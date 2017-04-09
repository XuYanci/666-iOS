//
//  AppDelegate.m
//  66GoodLook
//
//  Created by Yanci on 17/3/14.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "AppDelegate.h"
#import "ApplicationServiceBase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSArray <ApplicationService>*)fillServices {
    ApplicationServiceBase *base = nil;
    if (!base) {
        base = [[ApplicationServiceBase alloc]init];
    }
    return (NSArray <ApplicationService>*)[NSArray arrayWithObjects:base, nil];
}

@end
