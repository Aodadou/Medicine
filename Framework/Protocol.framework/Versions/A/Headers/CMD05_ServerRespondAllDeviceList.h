//
//  CMD05_ServerRespondAllDeviceList.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "CommonDevice.h"

///The server returns the user's list of all devices
@interface CMD05_ServerRespondAllDeviceList : ServerCommand<APPCommandProto>

///Device list
@property(nonatomic,strong) NSArray<CommonDevice *> * deviceList;

-(id)initWithDeviceList:(NSArray*)deviceList;

@end
