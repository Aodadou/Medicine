//
//  CMD93_SetLimitParameter.h
//  ClientProtocol
//
//  Created by chendy on 14-3-24.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "CommonDevice.h"

///Set device trigger
@interface CMD93_SetTriggerParameter : ClientCommand<APPCommandProto>

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

-(id)initWithType:(int)type Value:(double)value Enable:(BOOL)enable Action:(CommonDevice*)action;

@end
