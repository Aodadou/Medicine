//
//  UCMD00_InitialDevice.h
//  Protocol
//
//  Created by chendy on 14-7-15.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "UAPPCommand.h"

/// APP init device to link server
@interface UCMD00_InitialDevice : UAPPCommand<DCommandProto>

/// WIFI ssid
@property(strong,nonatomic) NSData* ssid;

/// WIFI password
@property(strong,nonatomic) NSData* pass;

/// Server address
@property(strong,nonatomic) NSData* host;

/// Server port(2)
@property(strong,nonatomic) NSData* port;

-(void)setSsidString:(NSString*)ssid;
-(NSString*)getSsidString;
-(void)setPassString:(NSString*)pass;
-(NSString*)getPassString;
-(void)setHostString:(NSString*)host;
-(NSString*)getHostString;
-(void)setPortInt:(int)port;
-(int)getPortInt;

-(id)initWithSsid:(NSString*)ssid Pass:(NSString*)pass Host:(NSString*)host Port:(int)port;

@end
