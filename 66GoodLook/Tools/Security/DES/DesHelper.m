//
//  des.m
//  qwe
//
//  Created by xuwen on 13-4-10.
//  Copyright (c) 2013年 xuwen. All rights reserved.
//

#import "DesHelper.h"
#import "GTMBase64.h"

@implementation DesHelper

+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOperation == kCCDecrypt) {
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [decryptData length];
        vplainText = [decryptData bytes];
    }
    
    else {
        
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [encryptData length];
        vplainText = (const void *)[encryptData bytes];
    }
    

    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    NSString *initVec = @"01234567";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    CCCryptorStatus ccStatus = CCCrypt(encryptOperation,
                                       kCCAlgorithm3DES,
                                       kCCOptionPKCS7Padding ,
                                       vkey,
                                       kCCKeySize3DES,
                                       vinitVec,
                                       vplainText,
                                       plainTextBufferSize,
                                       (void *)bufferPtr,
                                       bufferPtrSize,
                                       &movedBytes);
    
    NSString *result = nil;

    if (ccStatus == kCCSuccess)
        
    {
        
        if (encryptOperation == kCCDecrypt)
            
        {
            
            NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
            result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
            
        }
        
        else
            
        {
            
            NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
            
            result = [GTMBase64 stringByEncodingData:data];
        }
        
    }
    
    
    free(bufferPtr);
    return result;
    
}


+ (NSString *)encryptWithText:(NSString *)sText theKey:(NSString *)aKey

{
    
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:aKey];
    
}


+ (NSString *)decryptWithText:(NSString *)sText theKey:(NSString *)aKey

{
    
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:aKey];
    
}




@end
