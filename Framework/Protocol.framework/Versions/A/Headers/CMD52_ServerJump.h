//
//  CMD52_ServerJump.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server sends the client a jump instruction
///Do not use this command in the new system
@interface CMD52_ServerJump : ServerCommand<APPCommandProto>

///Jump to the server address
@property(nonatomic,strong) NSString* ip;

///Jump to the server's port
@property(nonatomic,assign) int port;

-(id)initWithIp:(NSString*)ip Port:(int)port;

@end
