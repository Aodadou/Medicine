//
//  CMD8C_ServerReturnGroupTimer.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "GroupTimerInfo.h"

///The server returns the group all timers
@interface CMD8C_ServerReturnGroupTimer : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString* groupId;

///Group timer list
@property(nonatomic,strong) NSArray<GroupTimerInfo *>* groupTimerList;

-(id)initWithGroupId:(NSString*)groupId GroupTimerList:(NSArray*)groupTimerList;

@end
