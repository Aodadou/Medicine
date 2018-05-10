//
//  CMD86_ServerAddGroupTimerSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerTask.h"
#import "ControlDeviceInfo.h"

///Add group timer successfully
@interface CMD86_ServerAddGroupTimerSucc : ServerCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString* groupId;


/// Scheduled task
@property(nonatomic,strong) TimerTask* schedinfo;


/// Control device info list
@property(nonatomic,strong) NSArray<ControlDeviceInfo *>* ctrlinfoList;

-(id)initWithGroupId:(NSString*)groupId Schedinfo:(TimerTask*)schedinfo CtrlinfoList:(NSArray*)ctrlinfoList;

@end
