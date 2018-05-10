//
//  CMD07_ServerRespondDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "CommonDevice.h"

///The server returns a single device status
@interface CMD07_ServerRespondDeviceStatus : ServerCommand<APPCommandProto>

///Device state
@property(strong,nonatomic) CommonDevice* device;

-(id)initWithDevice:(CommonDevice*)device;

@end
