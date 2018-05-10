//
//  CMD2A_SortNormalDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends modify sort commonly used equipment
@interface CMD2A_SortNormalDevice : ClientCommand<APPCommandProto>

///Common list of devices
@property(nonatomic,strong) NSArray* devices;

-(id)initWithDevices:(NSArray*)devices;

@end
