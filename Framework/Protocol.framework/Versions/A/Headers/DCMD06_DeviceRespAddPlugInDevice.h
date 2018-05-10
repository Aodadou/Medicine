//
//  DCMD06_DeviceRespAddPlugInDevice.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DClientCommand.h"

/**
 * Device response add 2.4G device success.<br>
 * DCommand No.6
 */
@interface DCMD06_DeviceRespAddPlugInDevice : DClientCommand<DCommandProto>

/// SN(7)
@property(strong,nonatomic) NSData* sn;

@property(assign,nonatomic) Byte result;

-(void)setSnString:(NSString*)sn;

-(NSString*)getSnString;

-(id)initWithSn:(NSString*)sn Result:(BOOL)result;

@end
