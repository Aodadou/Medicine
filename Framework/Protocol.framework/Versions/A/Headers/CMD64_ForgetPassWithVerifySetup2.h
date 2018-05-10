//
//  CMD64_ForgetPassWithVerifySetup2.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Forgot your password Step 2.(using the verification code to get password back)
@interface CMD64_ForgetPassWithVerifySetup2 : ClientCommand<APPCommandProto>

///User name
@property(nonatomic,strong) NSString<expose>* username;

///Email
@property(nonatomic,strong) NSString<expose>* email;

//Phone
@property(nonatomic,strong) NSString<expose>* phone;

/**
 * New password<br>
 * Null: The server sends a random password to the mailbox<br>
 * Not null: use for new password
 */
@property(nonatomic,strong) NSString<expose>* password;

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

///Verification code
@property(nonatomic,strong) NSString<expose>* code;

-(id)initWithUsername:(NSString*)username Email:(NSString*)email Phone:(NSString*)phone Pass:(NSString*)pass Uuid:(NSString*)uuid Code:(NSString*)code;

@end
