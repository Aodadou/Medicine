//
//  CMD7D_AddDevice2Group.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "ControlDeviceInfo.h"

///Add a group device sent by the client to the server (add a group device)
@interface CMD7D_AddDevice2Group : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong)NSString* groupId;

///Device ID
@property(nonatomic,strong)ControlDeviceInfo* deviceInfo;

-(id)initWithGroupId:(NSString*)grouId Devid:(NSString*)devid;

-(id)initWithGroupId:(NSString*)grouId DeviceInfo:(ControlDeviceInfo*)deviceInfo;

@end
