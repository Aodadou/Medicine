//
//  CMD18_AddTimerTask.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "TimerTask.h"
#import "ControlDeviceInfo.h"

///The client sends the command to add a single timed task
@interface CMD18_AddTimerTask : ClientCommand<APPCommandProto>

///Scheduled task
@property(nonatomic,strong) TimerTask* schedinfo;

///Device status
@property(nonatomic,strong) ControlDeviceInfo* ctrlinfo;

@property(nonatomic,strong,readonly) CommonDevice* device;

-(id)initWithSchedinfo:(TimerTask*)schedinfo Device:(CommonDevice*)device;

-(id)initWithSchedinfo:(TimerTask*)schedinfo Ctrlinfo:(ControlDeviceInfo*)ctrlinfo;

@end
