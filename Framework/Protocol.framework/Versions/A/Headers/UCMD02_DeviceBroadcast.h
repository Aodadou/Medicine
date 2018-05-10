//
//  UCMD02_DeviceBroadcast.h
//  Protocol
//
//  Created by chendy on 14-7-15.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "UDeviceCommand.h"

/**
 * Device broadcast info<br>
 * Use to send device server's ip and port to APP in local network
 */
@interface UCMD02_DeviceBroadcast : UDeviceCommand<DCommandProto>

/// Device server's ip(4)
@property(strong,nonatomic) NSData* host;

/// Device server port(2)
@property(strong,nonatomic) NSData* port;

-(void)setHostString:(NSString*)ip;
-(NSString*)getHostString;
-(void)setPortInt:(int)port;
-(int)getPortInt;

-(id)initWithHost:(NSString*)ip Port:(int)port;

@end
