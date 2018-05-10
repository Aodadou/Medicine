//
//  ThreeDES.m
//  MagicLights
//
//  Created by chendy on 13-5-25.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ThreeDES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>



@implementation ThreeDES
+(NSString*)encryptWithDefautKey:(NSString*)plainText{
    Byte byte[]={0x11, 0x22, 0x4F, 0x58,
        0x88, 0x38, 0x28, 0x25, 0x25, 0x79, 0x51,  0xCB, 0x30,
        0x40, 0x36, 0x28, 0x35, 0x29, 0x11, 0x4B, 0x40,  0xE8, 0x76,
        0x68};
    NSData *data=[[NSData alloc] initWithBytes:byte length:24];
    return [ThreeDES encrypt:plainText withKey:data];
}
+(NSString*)encrypt:(NSString*)plainText withKey:(NSData*)key {
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = [data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = [key bytes];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    if (ccStatus != kCCSuccess) {
        free(bufferPtr);
        return nil;
    }
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    free(bufferPtr);
    NSString *result = [self NSDataToHexString:myData];
    return result;
}

+(NSString*)NSDataToHexString:(NSData*) data {
    NSString* hexString = [[NSString alloc] init];
    int length = [data length];
    Byte* b = (Byte*)[data bytes];
    for (int i=0; i<length;i++) {
        hexString = [hexString stringByAppendingFormat:@"%02x",b[i]];
    }
    return hexString;
}

+(NSData*)HexStringToNSData:(NSString*) hexString {
    NSMutableData* data = [NSMutableData data];
    int length = [hexString length];
    int idx;
    for (idx = 0; idx+2<=length;idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [hexString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+ (NSString*)decrypt:(NSString*)encryptText withKey:(NSData*)key {
    NSData *encryptData = [self HexStringToNSData:encryptText];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = [key bytes];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       [key length],
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    if (ccStatus != kCCSuccess) {
        free(bufferPtr);
        return nil;
    }
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    free(bufferPtr);
    return result;
}

- (NSString*) sha1:(NSString*) hexString
{
    const char *cstr = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:hexString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
