//
//  DCommand.h
//  Protocol
//
//  Created by chendy on 14-7-8.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "JSONObject.h"

@protocol DCommandProto <NSObject>

@required
///The command's fix No., as a command's ID
+(Byte)commandConst;

///convert command object to bytes
-(NSData*)writeBytes;

///convert bytes to command object, use self instance
-(id)readBytes:(NSData*)data;

@end

/**
 * Base device command, all device command extend this include client command and server
 * command
 **/
@interface DCommand : JSONObject<DCommandProto> {
@public
    ///Command's ID store in byte
    Byte CommandNo;
    ///Protocol version
    Byte protocolVer;
}

/// Serial number, 2 bytes
@property(nonatomic,strong) NSData* serial;

/// Checksum, 4 bytes
@property(nonatomic,strong) NSData* checksum;

-(DCommand*)setParameterWithVersion:(Byte)ver Serial:(NSData*)serial Checksum:(NSData*) checksum;

@end
