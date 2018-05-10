//
//  CMD75_AddGroup.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends to the server to add a device group (adding group)
@interface CMD75_AddGroup : ClientCommand<APPCommandProto>

///Group name
@property(nonatomic,strong) NSString<expose>* groupName;

-(id)initWithGroupName:(NSString*)groupName;

@end
