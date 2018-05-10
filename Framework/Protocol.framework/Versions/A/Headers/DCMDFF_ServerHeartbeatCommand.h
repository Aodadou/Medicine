//
//  DCMDFF_ServerHeartbeatCommand.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DServerCommand.h"

/**
 * Server send heart beat<br>
 * DCommand No. FF
 */
@interface DCMDFF_ServerHeartbeatCommand : DServerCommand<DCommandProto>

@end
