//
//  CMD7C_ServerReturnAllGroupInfo.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "GroupInfo.h"

/** The server returns all the information about group from the server (group
  * information, group device information, and group timers)
  */
@interface CMD7C_ServerReturnAllGroupInfo : ServerCommand<APPCommandProto>

///Group Info List
@property(nonatomic,strong) NSArray<GroupInfo *>* groupInfoList;

-(id)initWithGroupInfo:(NSArray*)groupInfoList;

@end
