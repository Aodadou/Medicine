//
//  DCMD09_ServerControlDeviceCommand.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DServerCommand.h"

/**
 * Server control device.<br>
 * DCommand No.09
 */
@interface DCMD09_ServerControlDeviceCommand : DServerCommand<DCommandProto>

/// SN(7)
@property(strong,nonatomic) NSData* sn;

/// state(1~4)
@property(strong,nonatomic) NSData* state;

-(void)setSnString:(NSString*)sn;

-(NSString*)getSnString;

-(id)initWithSn:(NSString*)sn State:(NSData*)state;

@end
