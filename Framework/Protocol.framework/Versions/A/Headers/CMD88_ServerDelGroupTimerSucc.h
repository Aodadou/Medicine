//
//  CMD88_ServerDelGroupTimerSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns successfully remove a group timer
@interface CMD88_ServerDelGroupTimerSucc : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

///Scheduled ID
@property(nonatomic,strong) NSString<expose>* schedid;

-(id)initWithGroupId:(NSString*)groupId Schedid:(NSString*)schedid;

@end
