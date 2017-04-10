//
//  NSString+OAURLEncodingAdditions.h
//  Maxer
//
//  Created by XuYanci on 15/4/30.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OAURLEncodingAdditions)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end
