//
//  CMD22_DelTimer.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends the task to delete a single timed
@interface CMD22_DelTimer : ClientCommand<APPCommandProto>

///The GUID of scheduled tasks
@property(nonatomic,strong) NSString* schedid;

-(id)initWithSchedid:(NSString*)schedid;

@end
