//
//  CommandFactory.h
//  ClientProtocol
//
//  Created by chendy on 13-9-15.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientCommand.h"
#import "ServerCommand.h"

///Use for kinds of command operation
@interface CommandFactory : NSObject

///get a command's bytes for send
+(NSData*)getCommandByte:(ClientCommand*)cmd;

///Parse server command
+(ServerCommand*)parseServerCMD:(NSData*)data;

///Check data is illegal
+(BOOL)checkData:(NSData*)data;

@end
