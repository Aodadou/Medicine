//
//  NSDate+DSLCalendarView.m
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 16/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "NSDate+DSLCalendarView.h"


@implementation NSDate (DSLCalendarView)
- (NSDateComponents*)dslCalendarView_hourWithCalendar:(NSCalendar*)calendar {
    return [calendar components:kCFCalendarUnitHour | kCFCalendarUnitMinute | NSCalendarUnitCalendar  fromDate:self];
}
- (NSDateComponents*)dslCalendarView_dayWithCalendar:(NSCalendar*)calendar {
    return [calendar components: NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:self];
}

- (NSDateComponents*)dslCalendarView_monthWithCalendar:(NSCalendar*)calendar {
    return [calendar components:NSCalendarUnitCalendar | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
}
- (NSDateComponents*)dslCalendarView_day {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
//    NSInteger unitFlag =
    return [cal components:NSCalendarUnitCalendar | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:self];
}
@end
