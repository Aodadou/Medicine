//
//  AirConditionDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-6.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "CommonDevice.h"
#import "Power.h"

typedef enum {
    //auto mode
    AUTO_MODE = 0,
    //cool mode
    COOL_MODE,
    //dehumidification mode
    WET_MODE,
    //air mode
    WIND_MODE,
    //heating mode
    WARM_MODE
} AirMode;

typedef enum {
    // auto speed
    AUTO_SPEED = 0,
    //low-speed mode
    LOW_SPEED,
    //medium-speed mode
    MID_SPEED,
    //high-speed mode
    HI_SPEED
} AirSpeed;

typedef enum {
    //automatic placement
    AUTO_DIRECTION = 0,
    //directed placement
    VECT_DIRECTION,
    //up and down placement
    UP_DOWN_DIRECTION,
    //left and right placement
    LEFT_RIGHT_DIRECTION,
} AirDirection;

//Air Conditioning Information
@interface AirConditionDevice : Device

//power status, multi way
@property(nonatomic,assign) BOOL on;

//mode
@property(nonatomic,assign) AirMode mode;
//speed mode
@property(nonatomic,assign) AirSpeed speed;
//direction mode
@property(nonatomic,assign) AirDirection direction;
//temperature：16-30
@property(nonatomic,assign) int temperature;
//environment temperature: -64-64
@property(nonatomic,assign) int envtemp;
//vendor identification code
@property(nonatomic,assign) int manid;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)online Power:(BOOL)on Mode:(AirMode)mode Speed:(AirSpeed)speed Direction:(AirDirection)direction Temp:(int)temperature Envtemp:(int)envtemp;

@end
