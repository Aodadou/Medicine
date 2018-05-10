//
//  CMD7B_GetAllGroupInfo.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

/**
 * Get all the information about group from the server (group information, group
 * device information, and group timers)
 */
@interface CMD7B_GetAllGroupInfo : ClientCommand<APPCommandProto>

@end
