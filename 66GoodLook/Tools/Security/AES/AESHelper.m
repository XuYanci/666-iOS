//
//  AESHelper.m
//  FirstRoadNetwork
//
//  Created by Yanci on 17/1/10.
//  Copyright © 2017年 DYLY. All rights reserved.
//

#import "AESHelper.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>


@implementation NSData (AES)

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    bzero(ivPtr, sizeof(ivPtr));
    
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [self bytes], [self length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x00, //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    return nil;
}

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    bzero(ivPtr, sizeof(ivPtr));
    
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x00, //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    return nil;
}


@end


@implementation AESHelper


+ (NSString *)getHEX:(NSData *)data
{
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
    {
        return [NSString string];
    }
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
    {
        [hexString appendFormat:@"%02x", (unsigned int)dataBuffer[i]];
    }
    
    return [NSString stringWithString:hexString];
}

+ (NSString *)getString:(NSString *)hexString {
    const char *chars = [hexString UTF8String];
    NSUInteger i = 0, len = hexString.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)encryptWithText:(NSString *)sText theKey:(NSString *)aKey {
    NSData *encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
    encryptData =[encryptData AES128EncryptWithKey:aKey iv:@"9greqde7banhkxfv"];
    return [[[self class]getHEX:encryptData]uppercaseString];
}

+ (NSString *)decryptWithText:(NSString *)sText theKey:(NSString *)aKey {
    NSData *descryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
    descryptData = [descryptData AES128DecryptWithKey:aKey iv:@"9greqde7banhkxfv"];
    return [[self class]getString:[[NSString alloc]initWithData:descryptData encoding:NSUTF8StringEncoding]];
}
@end
