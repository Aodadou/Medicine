//
//  CMD0D_ServerAddMasterDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "CommonDevice.h"

///The server returns the results of adding WiFi devices
@interface CMD0D_ServerAddMasterDeviceResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Device state
@property(strong,nonatomic) CommonDevice* device;

-(id)initWithResult:(BOOL)result Device:(CommonDevice*)device;

@end
