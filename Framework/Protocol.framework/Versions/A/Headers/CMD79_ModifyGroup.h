//
//  CMD79_ModifyGroup.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends to the server to modify the device group (modifying group)
@interface CMD79_ModifyGroup : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

///Group name
@property(nonatomic,strong) NSString<expose>* groupName;

-(id)initWithGroupId:(NSString*)groupId GroupName:(NSString*)groupName;

@end
