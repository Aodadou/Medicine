//
//  AirPurifierDevice.h
//  ClientProtocol
//
//  Created by chendy on 14-6-26.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "CommonDevice.h"

/// Air purifier device
@interface AirPurifierDevice : CommonDevice

/// Inner PM2.5 value
@property(nonatomic,assign) int PM25;

/// Inner temperature
@property(nonatomic,assign) int temperature;

/// Inner humidity
@property(nonatomic,assign) int humidity;

/// TVOC value
@property(nonatomic,assign) int TVOC;

/**
 *  Clear time operation
 *  0:not clear, 1: clear filter time, 2:clear vitalight time
 */
@property(nonatomic,assign) int clearOperation;

/// Device working time
@property(nonatomic,assign) int working_time;

/// Filter used time
@property(nonatomic,assign) int filter_time;

/// Vitalight used time
@property(nonatomic,assign) int vitalight_time;

/// Device type number
@property(nonatomic,assign) int typeNumber;

/// Device power state
@property(nonatomic,assign) BOOL on;

/**
 *  Device timer - power off
 *  0:off 1,2,...7(hour)
 */
@property(nonatomic,assign) int timer;

/**
 *  Wind speed
 *  0:Auto 1,2,3,4
 */
@property(nonatomic,assign) int speed;

/// Ion state
@property(nonatomic,assign) BOOL ion;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)online On:(BOOL)on Timer:(int)timer Speed:(int)speed Ion:(BOOL)ion;

-(AirPurifierDevice *)readState:(NSData *)data;

@end
