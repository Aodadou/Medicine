//
//  PowerSocket.h
//  ClientProtocol
//
//  Created by chendy on 14-3-4.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "CommonDevice.h"

///The Socket can monitor voltage、power consumption and so on..
@interface PowerSocket : CommonDevice

/**
 * Switch status.
 * true:on, false:off
 */
@property(assign,nonatomic) BOOL on;
   
///Real Time Power
@property(assign,nonatomic) double realTimePower;

///Voltage
@property(assign,nonatomic) double voltage;

/**
 * Electric current<br>
 * 1~255
 */
@property(assign,nonatomic) double electricCurrent;

/**
 * Power factor<br>
 * 0.1~1
 */
@property(assign,nonatomic) double powerFactor;

///Power consumption
@property(assign,nonatomic) double powerConsumption;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(BOOL)on RealTimePower:(double)realTimePower Voltage:(double)voltage ElectricCurrent:(double)electricCurrent PowerFactor:(double)powerFactor PowerConsumption:(double)powerConsumption IconVer:(int)iconVer IconUrl:(NSString*)iconUrl;

@end
