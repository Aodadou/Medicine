//
//  ClientCommand.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "Command.h"

///Client Base command, all client command extend this
@interface ClientCommand : Command<APPCommandProto>

@end
