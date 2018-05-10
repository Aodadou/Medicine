//
//  DCMD07_ServerDeletePlugInDeviceCommand.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DServerCommand.h"

/**
 * Server delete hanging device<br>
 * DCommand No. 07
 */
@interface DCMD07_ServerDeletePlugInDeviceCommand : DServerCommand<DCommandProto>

/// SN(7)
@property(strong,nonatomic) NSData* sn;

-(void)setSnString:(NSString*)sn;

-(NSString*)getSnString;

-(id)initWithSn:(NSString*)sn;

@end
