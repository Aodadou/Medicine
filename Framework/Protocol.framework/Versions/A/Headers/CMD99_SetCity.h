//
//  CMD99_SetCity.h
//  ClientProtocol
//
//  Created by chendy on 14-6-30.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "ClientCommand.h"

/// Set city
@interface CMD99_SetCity : ClientCommand<APPCommandProto>

/// Device MAC address
@property(nonatomic,strong) NSString<expose> *mac;

/// City name
@property(nonatomic,strong) NSString<expose>* city;

-(id)initWithMac:(NSString*)mac City:(NSString*)city;

@end
