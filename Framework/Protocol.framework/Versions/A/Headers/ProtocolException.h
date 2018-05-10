//
//  ProtocolException.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"

///Exception Object define for protocol
@interface ProtocolException : JSONObject

///Error code
@property(nonatomic,assign) int code;

///Command's ID indicate which command execute errors
@property(nonatomic,assign) int CMDCode;

///Error message
@property(nonatomic,strong) NSString* info;

-(id)initWithCode:(int)code CommandCode:(int)cmdCode Info:(NSString*) info;

@end
