//
//  DeviceInfo.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import <Foundation/Foundation.h>



/// Device info
@interface DeviceInfo : NSObject

/// SN(7)
@property(strong,nonatomic) NSData* sn;

/// online(1)
@property(assign,nonatomic) Byte online;

/// state(1~4)
@property(strong,nonatomic) NSData* state;

-(id)initWithSN:(NSString*)sn Online:(BOOL)online State:(NSData*)state;

-(NSData*)writeBytes;

-(id)readBytes:(NSData*)data;

@end
