//
//  CMD7C_Object.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"
#import "CommonDevice.h"
#import "GroupTimerInfo.h"
#import "RawDevice.h"



///All group info (group info、group's devices and group's timers)
@interface GroupInfo : JSONObject

///Group id
@property(nonatomic,strong) NSString* groupId;

///Group name
@property(nonatomic,strong) NSString* groupName;

///Group icon version
@property(nonatomic,assign) int iconVer;

///Group icon url
@property(nonatomic,strong) NSString* iconUrl;

///Group's devices
@property(nonatomic,strong) NSArray<CommonDevice *> * deviceList;

@property(nonatomic,strong) NSArray<RawDevice *>* rawDeviceList;

///Group's timers
@property(nonatomic,strong) NSArray<GroupTimerInfo *>* groupTimerList;

-(id)initWithGroupId:(NSString*)groupId GroupName:(NSString*)groupName DeivceList:(NSArray*)deviceList TimerList:(NSArray*)timerList;

@end
