//
//  CMD0F_ServerAddSlaveDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "CommonDevice.h"

///The server returns the results of adding 2.4G devices
@interface CMD0F_ServerAddSlaveDeviceResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Device state
@property(strong,nonatomic) CommonDevice* device;

-(id)initWithResult:(BOOL)result Device:(CommonDevice*)device;

@end
