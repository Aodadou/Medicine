//
//  SKGAirPurifierDevice.h
//  Protocol
//
//  Created by chendy on 14/10/15.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "CommonDevice.h"

@interface SKGAirPurifierDevice : CommonDevice 

/// Device power state
@property(assign,nonatomic) BOOL on;

/// UV state
@property(assign,nonatomic) BOOL uv;

/// Ion state
@property(assign,nonatomic) BOOL ion;

/// Auto mode
@property(assign,nonatomic) BOOL autoMode;

/// Rapid smoking mode
@property(assign,nonatomic) BOOL RSMode;

/// Sleeping mode
@property(assign,nonatomic) BOOL sleepMode;

/// Inner PM2.5 value
@property(assign,nonatomic) int PM25;

/// Inner temperature
@property(assign,nonatomic) int temperature;

/// Inner humidity
@property(assign,nonatomic) int humidity;

/**
 * Wind speed<br>
 * 1~6
 */
@property(assign,nonatomic) int speed;

/**
 * Device timer - power off<br>
 *
 * 0:off 2 4 6 8(hour)
 */
@property(assign,nonatomic) int timer;

/// Filter used time
@property(assign,nonatomic) int filterTime;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)online On:(BOOL)on Uv:(BOOL)uv Ion:(BOOL)ion AutoMode:(BOOL)autoMode SleepMode:(BOOL)sleepMode Speed:(int)speed Timer:(int)timer;

-(SKGAirPurifierDevice *)readState:(NSData *)data;

@end
