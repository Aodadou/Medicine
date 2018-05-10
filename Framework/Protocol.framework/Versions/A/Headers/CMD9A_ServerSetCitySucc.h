//
//  CMD9A_ServerSetCitySucc.h
//  ClientProtocol
//
//  Created by chendy on 14-6-30.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "ServerCommand.h"

/// Server set city successfully
@interface CMD9A_ServerSetCitySucc : ServerCommand<APPCommandProto>

/// Device MAC address
@property(nonatomic,strong) NSString<expose> *mac;

/// City name
@property(nonatomic,strong) NSString<expose>* city;

-(id)initWithMac:(NSString*)mac City:(NSString*)city;

@end
