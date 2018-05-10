//
//  CMD67_ServerCheckUsernameAvailable.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns the user name is available (user name is not available, return FF command)
@interface CMD67_ServerCheckUsernameAvailable : ServerCommand<APPCommandProto>

@end
