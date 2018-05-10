//
//  CMD03_ServerLoginRespond.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "UserInfo.h"

///Server indicating whether the user is logged
@interface CMD03_ServerLoginRespond : ServerCommand<APPCommandProto>

///Login result
@property(nonatomic,assign) BOOL result;

///User info
@property(nonatomic,strong) UserInfo* info;

-(id)initWithResult:(BOOL)result Info:(UserInfo*)info;

@end
