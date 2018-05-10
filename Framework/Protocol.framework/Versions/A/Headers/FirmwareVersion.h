//
//  FirmwareVersion.h
//  Protocol
//
//  Created by jxm on 2017/6/14.
//  Copyright © 2017年 fortune. All rights reserved.
//

#import "JSONObject.h"

@interface FirmwareVersion : JSONObject
@property (nonatomic,strong) NSString* devId;
@property (nonatomic,strong) NSString* macAddr;
@property (nonatomic,assign) int type;
@property (nonatomic,strong) NSString* factorycode;
@property (nonatomic,strong) NSString* deviceCode;
@property (nonatomic,strong) NSString* firmwareVersion;

@end
