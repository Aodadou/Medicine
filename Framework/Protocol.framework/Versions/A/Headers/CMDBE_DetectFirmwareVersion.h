//
//  CMDBE_DetectFirmwareVersion.h
//  Protocol
//
//  Created by jxm on 2017/6/14.
//  Copyright © 2017年 fortune. All rights reserved.
//


#import "ClientCommand.h"

@interface CMDBE_DetectFirmwareVersion : ClientCommand
@property(strong,nonatomic) NSString *macAddr;
-(id)initWithMacId:(NSString*)macId;
@end
