//
//  CMD08_ControlDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "ControlDeviceInfo.h"

///Client send command to Control device state
@interface CMD08_ControlDevice : ClientCommand<APPCommandProto>

///Control device info
@property(strong,nonatomic) ControlDeviceInfo* ctrlinfo;

@property(strong,nonatomic,readonly) CommonDevice* device;

-(id)initWithControlDeviceInfo:(ControlDeviceInfo*)ctrlinfo;

-(id)initWithDevice:(CommonDevice*)device;

@end
