//
//  NuodeDeviceStatus.h
//  ClientProtocol
//
//  Created by chendy on 13-10-15.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"
#import "NuodeHangingDevice.h"

///Nuode device status
@interface NuodeDeviceStatus : JSONObject

///Date
@property(nonatomic,strong) NSString* date;

///Hanging device list
@property(nonatomic,strong) NSArray<NuodeHangingDevice *>* list;

-(id)initWithDate:(NSString*)date List:(NSArray*)list;

@end
