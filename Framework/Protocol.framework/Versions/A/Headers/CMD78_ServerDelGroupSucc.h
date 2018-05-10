//
//  CMD78_ServerDelGroupSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns successfully remove the device group
@interface CMD78_ServerDelGroupSucc : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

-(id)initWithGroupId:(NSString*)groupId;

@end
