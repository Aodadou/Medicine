//
//  DeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-5.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

///Plug device
#import <Foundation/Foundation.h>
#import "Power.h"
#import "JSONObject.h"
#import "CommonDevice.h"

@interface PlugDevice : CommonDevice

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)online Power:(NSArray*)powers;

///power status
@property(nonatomic,strong) NSArray<Power *>* powerList;

///set power status of first way
-(void)setOneWayPower:(BOOL)on;

/// get power status of first way
-(BOOL)getOneWayPower;

@end
