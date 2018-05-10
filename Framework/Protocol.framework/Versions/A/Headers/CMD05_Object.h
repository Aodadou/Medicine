//
//  CMD05_Object.h
//  ClientProtocol
//
//  Created by chendy on 14-2-12.
//  Copyright (c) 2014 year chendy. All rights reserved.
//

#import "CommandObject.h"
#import "Device.h"

@interface CMD05_Object : CommandObject

@property(nonatomic,strong)NSArray<Device*> *deviceList;

-(id)initWithCMDByte:(Byte)CMDByte DeviceList:(NSArray*)deviceList;

@end
