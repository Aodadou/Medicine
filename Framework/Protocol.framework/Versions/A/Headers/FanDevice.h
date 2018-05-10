//
//  FanDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-23.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "CommonDevice.h"

typedef enum {
    //low-speed
    SPEED_LOW = 0,
    //medium-speed
    SPEED_MID = 1,
    //high-speed
    SPEED_HI = 2,
}Speed;

///Fan device
@interface FanDevice : CommonDevice

/**
 * Fan power status.
 * true:On,false:Off.
 */
@property(nonatomic,assign) BOOL on;

///temperature
@property(nonatomic,assign) int temperature;

/**
 * wind speed
 * 0:low-speed, 1:medium-speed, 2:high-speed
 */
@property(nonatomic,assign) int speed;

///osc
@property(nonatomic,assign) BOOL osc;

///ion
@property(nonatomic,assign) BOOL ion;

/**
 * timer.
 * 1:after 1 hour, device will turn off, 2...
 */
@property(nonatomic,assign) int timer;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)online Power:(BOOL)on Temp:(int)temperature Speed:(int)speed Osc:(BOOL)osc Ion:(BOOL)ion Timer:(int)timer;

-(id)initWithPower:(BOOL)on Temp:(int)temperature Speed:(int)speed Osc:(BOOL)osc Ion:(BOOL)ion Timer:(int)timer;

@end
