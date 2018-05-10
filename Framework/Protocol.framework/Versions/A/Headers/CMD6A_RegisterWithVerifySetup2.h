//
//  CMD6A_RegisterWithVerifySetup2.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Register step 2.(Send registration information)
@interface CMD6A_RegisterWithVerifySetup2 : ClientCommand<APPCommandProto>

///User name
@property(nonatomic,strong) NSString<expose>* username;

///Password
@property(nonatomic,strong) NSString<expose>* password;

///Phone number
@property(nonatomic,strong) NSString<expose>* phone;

///Email
@property(nonatomic,strong) NSString<expose>* email;

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

///Verification code
@property(nonatomic,strong) NSString<expose>* code;

-(id)initWithUsername:(NSString*)username Pass:(NSString*)pass Phone:(NSString*)phone Email:(NSString*)email UUID:(NSString*)uuid Code:(NSString*)code;

@end
