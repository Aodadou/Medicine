//
//  CMD8D_ControlGroupDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "ControlDeviceInfo.h"
#import "SNDeviceTypeObject.h"

///The client sends to the server device control group (control device)
@interface CMD8D_ControlGroupDevice : ClientCommand<APPCommandProto>

///Group ID
@property(nonatomic,strong) NSString* groupId;

/**
 * Device state list<br>
 * Use as all group is not the same device
 */
@property(nonatomic,strong) NSArray<ControlDeviceInfo *>* ctrlinfoList;

/**
 * Control type<br>
 * 0、Control all，1、Control MAC，2、Control SN
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

-(id)initWithGroupId:(NSString*)groupId CtrlinfoList:(NSArray*)ctrlinfoList;

-(id)initWithGroupId:(NSString*)groupId CtrlinfoList:(NSArray*)ctrlinfoList ControlType:(int)controlType DeivceTypeList:(NSArray*)deviceTypeList SnTypeList:(NSArray*)snTypeList;


@end
