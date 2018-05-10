//
//  CMD77_DelGroup.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends to the server to delete the device group (Delete Group)
@interface CMD77_DelGroup : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

-(id)initWithGroupId:(NSString*)groupId;

@end
