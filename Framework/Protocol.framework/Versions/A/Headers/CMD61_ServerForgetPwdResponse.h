//
//  CMD61_ServerForgetPwdResponse.h
//  ClientProtocol
//
//  Created by chendy on 13-9-20.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns forgot password success (the new password sent to the user's mailbox)
@interface CMD61_ServerForgetPwdResponse : ServerCommand<APPCommandProto>

@end
