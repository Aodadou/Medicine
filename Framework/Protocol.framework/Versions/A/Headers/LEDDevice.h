//
//  LEDDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-9.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "CommonDevice.h"
#import "Power.h"

///LED Device
@interface LEDDevice : CommonDevice

///power status
@property(nonatomic,strong) NSArray<Power *>* powerList;

///brightness
@property(nonatomic,assign) int bright;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(NSArray*)powers Bright:(int)bright;

///set first power way status
-(void)setOneWayPower:(BOOL)on;

///get first power way status
-(BOOL)getOneWayPower;

@end
