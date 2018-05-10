//
//  CMD7F_DelDeviceFromGroup.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Delete device from specific group
@interface CMD7F_DelDeviceFromGroup : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong)NSString<expose>* groupId;

///Device ID
@property(nonatomic,strong)NSString<expose>* devid;

-(id)initWithGroupId:(NSString*)grouId Devid:(NSString*)devid;

@end
