//
//  CMD76_ServerAddGroupSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns the device group successfully added
@interface CMD76_ServerAddGroupSucc : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

///Group name
@property(nonatomic,strong) NSString<expose>* groupName;

-(id)initWithGroupId:(NSString*)groupId GroupName:(NSString*)groupName;

@end
