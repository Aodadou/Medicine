//
//  CMD93_Object.h
//  ClientProtocol
//
//  Created by chendy on 14-3-24.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "JSONObject.h"
#import "CommonDevice.h"
#import "RawDevice.h"



@interface TriggerInfo : JSONObject

/**
 * Parameter type<br>
 * 0:Max power, 1:Min power, ...
 */
@property(nonatomic,assign) int type;

///Limit value
@property(nonatomic,assign) double value;

///If enable, execute action when reach the limit value
@property(nonatomic,assign) BOOL enable;

///Action, control device
@property(nonatomic,strong) CommonDevice *action;

@property(nonatomic,strong) RawDevice* rawDevice;

-(id)initWithType:(int)type Value:(double)value Enable:(BOOL)enable Action:(CommonDevice*)action;

@end
