//
//  ServerCommand.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "Command.h"

///Server Base command, all server command extend this
@interface ServerCommand : Command<APPCommandProto>

///Set version and serial number
-(id)setProtocolVer:(Byte)protocolVer SerNum:(short)ser;

@end
