//
//  CMD2B_ServerSortNormalDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returned the result of  modifying the sort of commonly used equipment
@interface CMD2B_ServerSortNormalDeviceResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Commonly used equipment list
@property(nonatomic,strong) NSArray* deviceList;

-(id)initWithResult:(BOOL)result Devices:(NSArray*)deviceList;

@end
