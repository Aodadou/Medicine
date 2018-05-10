//
//  CMD71_VerifyCode.h
//  ClientProtocol
//
//  Created by chendy on 13-10-30.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Verify the verification code
@interface CMD71_VerifyCode : ClientCommand<APPCommandProto>

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

///Verification code
@property(nonatomic,strong) NSString<expose>* code;

-(id)initWithUUID:(NSString*)uuid Code:(NSString*)code;

@end
