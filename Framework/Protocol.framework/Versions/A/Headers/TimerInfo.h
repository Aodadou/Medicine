//
//  TimerInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"
#import "TimerTask.h"
#import "ControlDeviceInfo.h"



///Information of timer
@interface TimerInfo : JSONObject

///schedule info
@property(nonatomic,strong) TimerTask* schedinfo;

///device info
@property(nonatomic,strong) ControlDeviceInfo* ctrlinfo;

-(id)initWithSchedInfo:(TimerTask*)schedinfo_ CtrlInfo:(ControlDeviceInfo*)ctrlinfo_;

@end
