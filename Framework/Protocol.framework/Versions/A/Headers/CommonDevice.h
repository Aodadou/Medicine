//
//  CommonDevice.h
//  Protocol
//
//  Created by chendy on 14-7-7.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "Device.h"

@class CommonDevice;

@protocol CommonDeviceDL <NSObject>

@required
-(NSData*)writeState;
-(CommonDevice*)readState:(NSData*)data;
@end

@interface CommonDevice : Device<CommonDeviceDL>

-(NSData*)writeMask:(NSArray<NSNumber>*)indexes;

-(NSArray<NSNumber>*)readMask:(NSData*)mask;

-(void)defaultState:(NSString*)attach;

@end
