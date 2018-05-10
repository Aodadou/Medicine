//
//  GroupTimerInfo.h
//  Protocol
//
//  Created by chendy on 14-8-15.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "TimerInfo.h"



@interface GroupTimerInfo : JSONObject

@property(strong,nonatomic) NSArray<TimerInfo *>* timerInfoList;

-(id)initWithTimerInfoList:(NSArray<TimerInfo *>*)timerInfoList;

@end
