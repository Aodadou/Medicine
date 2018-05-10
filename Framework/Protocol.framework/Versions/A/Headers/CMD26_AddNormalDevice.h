//
//  CMD26_AddNormalDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "NormalDevice.h"

///The client sends the command to add a single common device
@interface CMD26_AddNormalDevice : ClientCommand<APPCommandProto>

///Common Device Information
@property(nonatomic,strong) NormalDevice* info;

-(id)initWithInfo:(NormalDevice*)info;

@end
