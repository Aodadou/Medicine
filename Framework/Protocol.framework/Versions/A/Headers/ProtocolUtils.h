//
//  ProtocolUtil.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandObject.h"
#import "Command.h"
#import "ControlDeviceInfo.h"

typedef enum {
    // Print all message
    LOG_LEVEL_INFO = 0,
    // Print dump message
    LOG_LEVEL_DUMP,
    // Print publish message
    LOG_LEVEL_PUBLISH,
    // Print warn message
    LOG_LEVEL_WARN,
    // Print error message
    LOG_LEVEL_ERROR
}LogLevel;

@interface ProtocolUtils : NSObject

+(id)getGsonInstance;

+(id)getExcludeAnnotationGsonInstance;

//Merge CMDByte with JSON String
+(NSData*)getBytesWithCommandNo:(Byte)commandNo JSON:(NSString*)jsonString;

+(void)log:(NSObject*)msg level:(int)level;

//calculate data's checkSum
+(NSData*)calAPPChecksum:(NSData*)data;

+(NSData*)setAPPChecksum:(NSData*)data;

//Set log's level for printing message
+(void)setLogLevel:(LogLevel)level ;

+(CommandObject*)Command2Object:(Command*)cmd;

+(Command*)Object2Command:(CommandObject*)co;

+(NSData*)writePowerList:(NSArray*)powerList;

+(NSArray*)readPowerList:(NSData*)data withIndex:(int)index;

+(RawDevice*)convert2RawDevice:(CommonDevice*)device;

+(CommonDevice*)convert2CommonDevice:(RawDevice*)device;

+(void)prepareTransfer:(id)info;

+(void)endTransfer:(id)info;

@end
