//
//  CMD96_Object.h
//  ClientProtocol
//
//  Created by chendy on 14-4-29.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "JSONObject.h"
#import "TriggerInfo.h"

@interface CMD96_Object : JSONObject

///Device MAC address
@property(nonatomic,strong) NSString* mac;

/**
 * Query type
 * -1: all, 0:Max power, 1:Min power, ...
 */
@property(nonatomic,strong) NSNumber* queryType;

/**
 * Device trigger info
 * TriggerInfo instance List
 */
@property(nonatomic,strong) NSArray<TriggerInfo *> *triggerInfos;

-(id)initWithMac:(NSString*)mac QueryType:(int)queryType TriggerInfos:(NSArray*)triggerInfos;

@end
