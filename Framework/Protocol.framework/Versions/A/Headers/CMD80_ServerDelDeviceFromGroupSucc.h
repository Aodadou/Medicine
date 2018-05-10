//
//  CMD80_ServerDelDeviceFromGroupSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///Delete device from specific group successfully
@interface CMD80_ServerDelDeviceFromGroupSucc : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

///Device ID
@property(nonatomic,strong) NSString<expose>* devid;

-(id)initWithGroupId:(NSString*)groupId Devid:(NSString*)devid;

@end
