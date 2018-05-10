//
//  CMD82_ServerModifyGroupDevicesSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "ControlDeviceInfo.h"

///Modify group devices successfully
@interface CMD82_ServerModifyGroupDevicesSucc : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong)NSString* groupId;

///Device ID list
@property(nonatomic,strong)NSArray<ControlDeviceInfo *>* deviceList;

-(id)initWithGroupId:(NSString*)groupId DeviceList:(NSArray*)deviceList;

@end
