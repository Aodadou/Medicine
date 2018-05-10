//
//  CMDFF_ServerException.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns exception package
@interface CMDFF_ServerException : ServerCommand<APPCommandProto>

///Error code
@property(nonatomic,assign) int code;

///Error command's ID
@property(nonatomic,assign) int CMDCode;

///Error message
@property(nonatomic,strong) NSString* info;

-(id)initWithCode:(int)code CommandCode:(int)cmdCode Info:(NSString*) info;

@end
