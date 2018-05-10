//
//  CMD7E_ServerAddDevice2GroupSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "ControlDeviceInfo.h"

///The server returns the device successfully added group
@interface CMD7E_ServerAddDevice2GroupSucc : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString* groupId;

///Device ID
@property(nonatomic,strong) ControlDeviceInfo* deviceInfo;

-(id)initWithGroupId:(NSString*)groupId DeviceInfo:(ControlDeviceInfo *)deviceInfo;

@end
