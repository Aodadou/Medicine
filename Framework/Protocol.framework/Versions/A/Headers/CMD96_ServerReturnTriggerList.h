//
//  CMD96_ServerReturnTriggerList.h
//  ClientProtocol
//
//  Created by chendy on 14-4-29.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///Return device triggers to client
@interface CMD96_ServerReturnTriggerList : ServerCommand<APPCommandProto>

///Device MAC address
@property(nonatomic,strong) NSString* mac;

/**
 * Query type
 * -1: all, 0:Max power, 1:Min power, ...
 */
@property(nonatomic,assign) int queryType;

/**
 * Device trigger info
 * TriggerInfo instance List
 */
@property(nonatomic,strong) NSArray *triggerInfos;

-(id)initWithMac:(NSString*)mac QueryType:(int)queryType TriggerInfos:(NSArray*)triggerInfos;

@end
