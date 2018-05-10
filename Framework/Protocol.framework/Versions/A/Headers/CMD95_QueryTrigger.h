//
//  CMD95_QueryTrigger.h
//  ClientProtocol
//
//  Created by chendy on 14-4-29.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "ClientCommand.h"

/// Query device limit parameter
@interface CMD95_QueryTrigger : ClientCommand<APPCommandProto>

/**
 * Query type
 * -1: all, 0:Max power, 1:Min power, ...
 */
@property(nonatomic,strong) NSString<expose> *mac;

///Device MAC address
@property(nonatomic,strong) NSNumber<expose> *queryType;

-(id)initWithMac:(NSString*)mac;

-(id)initWithMac:(NSString*)mac QueryType:(int)queryType;

@end
