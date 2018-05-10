//
//  CMD96_Object.h
//  ClientProtocol
//
//  Created by chendy on 14-4-2.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "JSONObject.h"
#import "Record.h"

@interface CMD98_Object : JSONObject

@property(nonatomic,strong) NSString *mac;

@property(nonatomic,assign) int type;

@property(nonatomic,strong) NSString *startDate;

@property(nonatomic,strong) NSString *endDate;

@property(nonatomic,strong) NSArray<Record *> *records;

-(id)initWithMac:(NSString*)mac Type:(int)type StartDate:(NSString*)startDate EndDate:(NSString*)endDate Records:(NSArray*)records;

@end
