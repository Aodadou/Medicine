//
//  CMD85_AddGroupTimer.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "TimerTask.h"
#import "ControlDeviceInfo.h"
#import "SNDeviceTypeObject.h"

///Add group timer
@interface CMD85_AddGroupTimer : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString* groupId;

/**
 * Scheduled task<br>
 * Use when the all group's device are the same type
 */
@property(nonatomic,strong) TimerTask* schedinfo;

/// Control device info List
@property(nonatomic,strong) NSArray<ControlDeviceInfo *>* ctrlinfoList;

/**
 * Control type<br>
 * 0、Control all，1、Control MAC，2、Control SN
 *
 */
@property(nonatomic,assign) int controlType;

/**
 * A list of device types WIFI devices, used to specify when controlType is
 * 1, which WIFI device group control<br>
 * controlType is 0, not to set this value
 */
@property(nonatomic,strong) NSArray<NSNumber>* deviceTypeList;

/**
 * A list of device types SN devices, used to specify when controlType is 2,
 * which SN device group control<br>
 * controlType is 0, not to set this value
 */
@property(nonatomic,strong) NSArray<SNDeviceTypeObject *>* snTypeList;

-(id)initWithGroupId:(NSString*)groupId Schedinfo:(TimerTask*)schedinfo CtrlinfoList:(NSArray*)ctrlinfo;

-(id)initWithGroupId:(NSString*)groupId Schedinfo:(TimerTask*)schedinfo CtrlinfoList:(NSArray*)ctrlinfo ControlType:(int)controlType DeivceTypeList:(NSArray*)deviceTypeList SnTypeList:(NSArray*)snTypeList;

@end
