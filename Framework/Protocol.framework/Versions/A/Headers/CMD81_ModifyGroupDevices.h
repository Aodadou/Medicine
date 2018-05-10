//
//  CMD81_ModifyGroupDevices.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "ControlDeviceInfo.h"

///Modify group devices
@interface CMD81_ModifyGroupDevices : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong)NSString* groupId;

///Device ID list
@property(nonatomic,strong)NSArray<ControlDeviceInfo *>* deviceList;

-(id)initWithGroupId:(NSString*)groupId DeviceList:(NSArray*)deviceList;

@end
