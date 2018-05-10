//
//  CMD84_ServerRetrunGroupDevices.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "CommonDevice.h"

///The server returns all Group device information
@interface CMD84_ServerRetrunGroupDevices : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString* groupId;

///Device List
@property(nonatomic,strong) NSArray<CommonDevice *> * deviceList;

-(id)initWithGroupId:(NSString*)groupId DeviceList:(NSArray*)deviceList;

@end
