//
//  CMD19_ServerAddTimerResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerTask.h"
#import "ControlDeviceInfo.h"

///The server returned the results of adding scheduled task
@interface CMD19_ServerAddTimerResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Scheduled task
@property(nonatomic,strong) TimerTask* schedinfo;

///Device info
@property(nonatomic,strong) ControlDeviceInfo* ctrlinfo;

-(id)initWithResult:(BOOL)result Schedinfo:(TimerTask*)schedinfo Ctrlinfo:(ControlDeviceInfo*)ctrlinfo;

@end
