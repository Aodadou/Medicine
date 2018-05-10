//
//  DCMD01_DeviceUpInfo.h
//  Protocol
//
//  Created by chendy on 14-7-9.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DClientCommand.h"

/**
 * Device ppload identity information packet.<br>
 * DCommand No. 01
 */
@interface DCMD01_DeviceUpInfo : DClientCommand<DCommandProto>

/// Device MAC(6)
@property(strong,nonatomic) NSData* mac;

/// Device type(1)
@property(assign,nonatomic) Byte type;

/// Device IP(4)
@property(strong,nonatomic) NSData* deviceIp;

/// Route MAC(6)
@property(strong,nonatomic) NSData* routeMac;

/// Control center flag(1)
@property(assign,nonatomic) Byte centerFlag;

-(id)initWithMac:(NSString*)mac Type:(int)type DeviceIp:(NSString*)deviceIp RouteMac:(NSString*)routeMac CenterFlag:(BOOL)flag;

-(NSString*)macString;
-(void)setMacString:(NSString*)macString;
-(NSString*)deviceIpString;
-(void)setDeviceIpString:(NSString*)ipString;
-(NSString*)routeMacString;
-(void)setRouteMacString:(NSString*)routeMacString;

@end
