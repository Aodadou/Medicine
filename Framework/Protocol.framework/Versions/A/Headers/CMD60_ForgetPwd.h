//
//  CMD60_ForgetPwd.h
//  ClientProtocol
//
//  Created by chendy on 13-9-20.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

/**
 * Forgot your password sent by the client to the server (the new password will
 * be sent directly to the user's mailbox)
 *
 * This is unsafe, use CMD62 and CMD64 instead
 */
DEPRECATED_ATTRIBUTE @interface CMD60_ForgetPwd : ClientCommand<APPCommandProto>

///User name
@property(nonatomic,strong) NSString* username;

///Email
@property(nonatomic,strong) NSString* email;

-(id)initWithUsername:(NSString*)username Email:(NSString*)email;

@end
