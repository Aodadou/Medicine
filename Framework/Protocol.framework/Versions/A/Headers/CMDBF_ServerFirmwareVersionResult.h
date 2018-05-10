//
//  CMDBF_ServerFirmwareVersionResult.h
//  Protocol
//
//  Created by jxm on 2017/6/14.
//  Copyright © 2017年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "FirmwareVersion.h"
@interface CMDBF_ServerFirmwareVersionResult : ServerCommand
@property(strong,nonatomic) FirmwareVersion* firmwareVersion;
@end
