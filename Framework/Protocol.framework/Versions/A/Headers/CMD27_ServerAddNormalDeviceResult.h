//
//  CMD27_ServerAddNormalDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "NormalDevice.h"

///The server returned the results of adding commonly used equipment
@interface CMD27_ServerAddNormalDeviceResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Commonly used device information
@property(nonatomic,strong) NormalDevice* device;

-(id)initWithResult:(BOOL)result Device:(NormalDevice*)device;

@end
