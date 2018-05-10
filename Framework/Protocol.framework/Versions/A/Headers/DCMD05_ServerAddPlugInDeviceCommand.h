//
//  DCMD05_ServerAddPlugInDeviceCommand.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DServerCommand.h"

@interface DCMD05_ServerAddPlugInDeviceCommand : DServerCommand<DCommandProto>

/// SN(7)
@property(strong,nonatomic) NSData* sn;

-(void)setSnString:(NSString*)sn;

-(NSString*)getSnString;

-(id)initWithSn:(NSString*)sn;

@end
