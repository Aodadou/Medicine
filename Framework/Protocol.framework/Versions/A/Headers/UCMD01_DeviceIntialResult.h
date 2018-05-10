//
//  UCMD01_DeviceIntialResult.h
//  Protocol
//
//  Created by chendy on 14-7-15.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "UDeviceCommand.h"

/// Device response initial result
@interface UCMD01_DeviceIntialResult : UDeviceCommand<DCommandProto>

@property(assign,nonatomic) Byte result;

-(id)initWithResult:(BOOL)result;

@end
