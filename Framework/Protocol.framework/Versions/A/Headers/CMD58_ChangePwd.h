//
//  CMD58_ChangePwd.h
//  ClientProtocol
//
//  Created by chendy on 13-9-18.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Change Password
@interface CMD58_ChangePwd : ClientCommand<APPCommandProto>

///User name
@property(nonatomic,strong) NSString* username;

///New password
@property(nonatomic,strong) NSString* pass;

///Old password
@property(nonatomic,strong) NSString* oldPassword;

-(id)initWithUsername:(NSString*)username OldPass:(NSString*)oldPassword NewPass:(NSString*)newPassword;

@end
