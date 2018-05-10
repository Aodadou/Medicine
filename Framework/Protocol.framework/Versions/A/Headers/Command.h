//
//  Command.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"

@protocol APPCommandProto <NSObject>

@required

///The command's fix No., as a command's ID
+(Byte)commandConst;

///convert command object to bytes
-(NSData*)writeBytes;

///convert bytes to command object, use self instance
-(id)readBytes:(NSData*)data;

@end

/**
 * Base command, all command extend this include client command and server
 * command
 **/
@interface Command : JSONObject {
    @public
    ///Command's ID store in byte
    Byte CommandNo;
    ///Protocol version
    Byte protocolVer;
}

///Serial number
@property(nonatomic,assign) short SerNum;
-(Byte)getCommandNo;
@end
