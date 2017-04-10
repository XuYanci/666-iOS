//
//  AESHelper.h
//  FirstRoadNetwork
//
//  Created by Yanci on 17/1/10.
//  Copyright © 2017年 DYLY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;
@end


@interface AESHelper : NSObject
+ (NSString *)encryptWithText:(NSString *)sText theKey:(NSString *)aKey;
+ (NSString *)decryptWithText:(NSString *)sText theKey:(NSString *)aKey;
@end
