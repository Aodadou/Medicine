//
//  CMD96_ServerReturnHistoryRecord.h
//  ClientProtocol
//
//  Created by chendy on 14-4-2.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "Record.h"

@interface CMD98_ServerReturnHistoryRecord : ServerCommand<APPCommandProto>

///Device MAC address
@property(nonatomic,strong) NSString *mac;

/**
 * Query type
 * 0: today, 1: week, 2: month
 */
@property(nonatomic,assign) int type;

/// Start date to query
@property(nonatomic,strong) NSString *startDate;

///End date to query
@property(nonatomic,strong) NSString *endDate;

/**
 * History records
 * Order by time asc
 */
@property(nonatomic,strong) NSArray<Record *>* records;

-(id)initWithMac:(NSString*)mac Type:(int)type StartDate:(NSString*)startDate EndDate:(NSString*)endDate Records:(NSArray*)records;

@end
