//
//  CMD95_QueryHistoryRecord.h
//  ClientProtocol
//
//  Created by chendy on 14-4-2.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///Query device status history records
@interface CMD97_QueryHistoryRecord : ClientCommand<APPCommandProto>

///Device MAC address
@property(nonatomic,strong) NSString *mac;

/**
 * Query type
 * 0: Statistical power (draw a line), 1: Total power (costed)
 */
@property(nonatomic,assign) int type;

/// Start date to query
@property(nonatomic,strong) NSString *startDate;

///End date to query
@property(nonatomic,strong) NSString *endDate;

-(id)initWithMac:(NSString*)mac Type:(int)type StartDate:(NSString*)startDate EndDate:(NSString*)endDate;

@end
