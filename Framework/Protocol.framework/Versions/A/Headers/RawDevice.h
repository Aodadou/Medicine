//
//  RawDevice.h
//  Protocol
//
//  Created by chendy on 14-10-10.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "Device.h"



@interface RawDevice : Device

/// Device state in hex string
@property(strong,nonatomic) NSString* state;

-(instancetype)initWithCategory:(int)category Type:(int)type Id:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Version:(int)version Online:(BOOL)online IconVer:(int)iconVer IconUrl:(NSString*)iconUrl Center:(BOOL)center State:(NSString*)state;

@end
