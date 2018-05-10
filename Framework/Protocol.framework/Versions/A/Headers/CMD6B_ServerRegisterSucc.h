//
//  CMD6B_ServerRegisterSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns the registration is successful (failure to return FF command)
@interface CMD6B_ServerRegisterSucc : ServerCommand<APPCommandProto>

@end
