//
//  des.h
//  qwe
//
//  Created by xuwen on 13-4-10.
//  Copyright (c) 2013年 xuwen. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>

@interface DesHelper : NSObject

+ (NSString *)encryptWithText:(NSString *)sText theKey:(NSString *)aKey;
+ (NSString *)decryptWithText:(NSString *)sText theKey:(NSString *)aKey;

@end
