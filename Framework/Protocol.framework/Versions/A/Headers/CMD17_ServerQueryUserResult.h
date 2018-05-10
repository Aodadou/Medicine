//
//  CMD17_ServerQueryUserResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "UserInfo.h"

///The server returned the information of user
@interface CMD17_ServerQueryUserResult : ServerCommand<APPCommandProto>

///User information
@property(nonatomic,strong) UserInfo* userInfo;

-(id)initWithUserInfo:(UserInfo*)info;

@end
