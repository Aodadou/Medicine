//
//  CMD06_QueryDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Client queries the status of individual devices
@interface CMD06_QueryDeviceStatus : ClientCommand<APPCommandProto>

///Device ID
@property(nonatomic,strong) NSString* devid;

-(id)initWithDevid:(NSString*)devid;

@end
