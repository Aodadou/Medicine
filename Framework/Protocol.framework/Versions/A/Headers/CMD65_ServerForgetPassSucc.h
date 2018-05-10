//
//  CMD65_ServerForgetPassSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns forgot your password successfully (failure to return CMDFF command)
@interface CMD65_ServerForgetPassSucc : ServerCommand<APPCommandProto>

@end
