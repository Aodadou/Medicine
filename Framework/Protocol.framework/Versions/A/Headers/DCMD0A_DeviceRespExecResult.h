//
//  DCMD0A_DeviceRespExecResult.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DClientCommand.h"

/**
 * Device response control result.<br>
 * DCommand No. 0A
 */
@interface DCMD0A_DeviceRespExecResult : DClientCommand<DCommandProto>

/// SN(7)
@property(strong,nonatomic) NSData* sn;

/// online(1)
@property(assign,nonatomic) Byte online;

/// state(1~4)
@property(strong,nonatomic) NSData* state;

-(void)setSnString:(NSString*)sn;

-(NSString*)getSnString;

-(id)initWithSn:(NSString*)sn Online:(BOOL)online State:(NSData*)state;

@end
