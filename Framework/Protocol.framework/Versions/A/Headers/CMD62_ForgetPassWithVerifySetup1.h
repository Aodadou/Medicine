//
//  CMD62_ForgetPassWithVerifySetup1.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Forgot your password Step 1. (to obtain verification code)
@interface CMD62_ForgetPassWithVerifySetup1 : ClientCommand<APPCommandProto>

//User name
@property(nonatomic,strong) NSString<expose>* username;

//Email
@property(nonatomic,strong) NSString<expose>* email;

//Phone
@property(nonatomic,strong) NSString<expose>* phone;

-(id)initWithUsername:(NSString*)username Email:(NSString*)email Phone:(NSString*)phone;

@end
