//
//  CMD87_DelGroupTimer.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Client sent to the server to delete the group timer (Delete Group Timer)
@interface CMD87_DelGroupTimer : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

///Scheduled Task ID
@property(nonatomic,strong) NSString<expose>* schedid;

-(id)initWithGroupId:(NSString*)groupId Schedid:(NSString*)schedid;

@end
