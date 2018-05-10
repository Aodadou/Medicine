//
//  YSLDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-29.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "Device.h"

///YSL device
@interface YSLDevice : Device

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine;

@end
