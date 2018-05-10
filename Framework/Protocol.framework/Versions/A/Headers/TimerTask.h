//
//  TimerTask.h
//  NewProtocol
//
//  Created by chendy on 13-9-9.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"



///Scheduled Task
@interface TimerTask : JSONObject

///GUID
@property(nonatomic,strong) NSString* id;

///hour
@property(nonatomic,assign) int hour;

///minute
@property(nonatomic,assign) int minute;

///Array[set true to perform this task in a week day]
@property(nonatomic,strong) NSArray<NSNumber>* day;

///repeated
@property(nonatomic,assign) BOOL repeated;

///enabled
@property(nonatomic,assign) BOOL enabled;

/**
 * repeat unit <br>
 * 0, 1, 2 … (0: previous week repeat mode，1: hour，2:
 * day，3：week，4：month，5：quarter，6：year，...)
 */
@property(nonatomic,assign) int repeatOption;

/**
 * repeat times<br>
 * -1,0, 1, 2… (-1: infinite loop，0: no loop，...)
 */
@property(nonatomic,assign) int repeatTime;

/**
 * Repeat Interval<br>
 * 0,1, 2, 3, 4,...
 */
@property(nonatomic,strong) NSNumber* repeatGap;

/**
 * week of day<br>
 * 1,2,3,4,5,6
 */
@property(nonatomic,strong) NSNumber* date;

/**
 * year of month<br>
 * 1,2,3,4,5,6,..12
 */
@property(nonatomic,strong) NSNumber* month;

///year
@property(nonatomic,strong) NSNumber* year;

/**
 * number of week in month<br>
 * 1, 2,3,4
 */
@property(nonatomic,strong) NSNumber* weekNumMonthly;

/**
 * number of week in year<br>
 * 1,2,...,54
 */
@property(nonatomic,strong) NSNumber* weekNumYear;

/**
 * number of day in year<br>
 * 1,2,3,..,365
 */
@property(nonatomic,strong) NSNumber* dayNumYear;

@property(nonatomic,strong) NSString* timerGroupId;

@property(nonatomic,strong) NSString* Remark1;

@property(nonatomic,strong) NSString* Remark2;

@property(nonatomic,strong) NSString* Remark3;

@property(nonatomic,strong) NSString* Remark4;

@property(nonatomic,strong) NSString* Remark5;

-(id)initWithId:(NSString*)id_ Hour:(int)hour_ Minute:(int)minute_ Day:(NSArray<NSNumber>*)day_ Repeated:(BOOL)repeated Enable:(BOOL)enabled_;

@end
