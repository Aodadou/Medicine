//
//  CMD8E_ServerControlGroupDeviceSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "CommonDevice.h"

///The server returns the control group device successfully
@interface CMD8E_ServerControlGroupDeviceSucc : ServerCommand<APPCommandProto>

/// Group ID
@property(nonatomic,strong) NSString* groupId;

/// Device state list
@property(nonatomic,strong) NSArray<CommonDevice *> * ctrlinfoList;

-(id)initWithGroupId:(NSString*)groupId CtrlinfoList:(NSArray*)ctrlinfoList;

@end
