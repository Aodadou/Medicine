//
//  SocketDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-23.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "CommonDevice.h"

///YSL socket hanging device
@interface SocketDevice : CommonDevice

///Hanging device type
@property(nonatomic,assign) int subType;

///Power state.
@property(nonatomic,assign) BOOL on;

//Consumption
@property(nonatomic,assign) int consumption;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(BOOL)on Consumption:(int)consumption;

@end
