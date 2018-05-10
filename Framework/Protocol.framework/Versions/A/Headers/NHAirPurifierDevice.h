//
//  NHAirPurifierDevice.h
//  Protocol
//
//  Created by chendy on 14-10-8.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "CommonDevice.h"

@interface NHAirPurifierDevice : CommonDevice

///  Device power state
@property(assign,nonatomic) BOOL on;

/**
 * Device timer - power off<br>
 *
 * 0:off 1,2,...12(hour)
 */
@property(assign,nonatomic) int timer;

/// Ion state
@property(assign,nonatomic) BOOL ion;

/**
 * Wind speed<br>
 * 0:quiet, 1:low, 2:middle, 3:high
 */
@property(assign,nonatomic) int speed;

/// Child lock
@property(assign,nonatomic) BOOL lock;

/// Filter used time
@property(assign,nonatomic) int filterTime;

/**
 * Mode<br>
 * 0:normal, 1:auto, 2:sleep
 */
@property(assign,nonatomic) int mode;

/// Inner PM2.5 value
@property(assign,nonatomic) int PM25;

/// TVOC value
@property(assign,nonatomic) int TVOC;

/// Inner temperature
@property(assign,nonatomic) int temperature;

/// Inner humidity
@property(assign,nonatomic) int humidity;

/// Warning value
@property(assign,nonatomic) int warningValue;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)online On:(BOOL)on Timer:(int)timer Speed:(int)speed Ion:(BOOL)ion Lock:(BOOL)lock Mode:(int)mode;

-(NHAirPurifierDevice *)readState:(NSData *)data;

@end
