//
//  SNDeviceTypeObject.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"



///Identify the type of hanging device
@interface SNDeviceTypeObject : JSONObject

///hanging device's major type
@property(nonatomic,assign) int deviceType;

///hanging device's minor type
@property(nonatomic,assign) int subType;

-(id)initWithDeviceType:(int)deviceType SubType:(int)subType;

@end
