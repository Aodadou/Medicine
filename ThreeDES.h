//
//  ThreeDES.h
//  MagicLights
//
//  Created by chendy on 13-5-25.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define gkey @"b0326c4f1e0e2c2970584b14a5a36d1886b4b115"
#define gIv  @"01234567"
#define kSecrectKeyLength 24
@interface ThreeDES : NSObject

+(NSString*)encryptWithDefautKey:(NSString*)plainText;
//加密,key为byte数组NSData
+ (NSString*)encrypt:(NSString*)plainText withKey:(NSData*)key;
//解密,key为byte数组的NSData
+ (NSString*)decrypt:(NSString*)encryptText withKey:(NSData*)key;
//16进制字符串转成NSData
+ (NSData*)HexStringToNSData:(NSString*) hexString;
//NSData转成16进制
+ (NSString*)NSDataToHexString:(NSData*) data;

- (NSString*) sha1:(NSString*) hexString;
@end
