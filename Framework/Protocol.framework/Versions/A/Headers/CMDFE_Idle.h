//
//  CMDFE_Idle.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

/**
 * The client sends heartbeat packets<br>
 * Replaced with CMDFB and CMDFC command
 */
DEPRECATED_ATTRIBUTE @interface CMDFE_Idle : ClientCommand<APPCommandProto>

@end
