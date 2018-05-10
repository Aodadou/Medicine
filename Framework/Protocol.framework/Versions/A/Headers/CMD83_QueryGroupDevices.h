//
//  CMD83_QueryGroupDevices.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Query groups of all device information
@interface CMD83_QueryGroupDevices : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString<expose>* groupId;

-(id)initWithGroupId:(NSString*)groupId;

@end
