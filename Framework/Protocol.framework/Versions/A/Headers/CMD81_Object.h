//
//  CMD81_Object.h
//  Protocol
//
//  Created by chendy on 14-10-11.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "JSONObject.h"
#import "ControlDeviceInfo.h"

@interface CMD81_Object : JSONObject

///Group ID
@property(nonatomic,strong)NSString* groupId;

///Device ID list
@property(nonatomic,strong)NSArray<ControlDeviceInfo *>* deviceList;

-(id)initWithGroupId:(NSString*)groupId DeviceList:(NSArray*)deviceList;

@end
