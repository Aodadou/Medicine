//
//  CMD63_ServerReturnValidateCode.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns uuid (verification code sent to the user's mailbox)
@interface CMD63_ServerReturnValidateCode : ServerCommand<APPCommandProto>

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

-(id)initWithUUID:(NSString*)uuid;

@end
