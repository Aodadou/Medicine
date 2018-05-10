//
//  CMD25_ServerQueryTimerResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerInfo.h"

///The server returned device's all scheduled tasks
@interface CMD25_ServerQueryTimerResult : ServerCommand<APPCommandProto>

///Device ID
@property(nonatomic,strong) NSString* devid;

///Scheduled task list
@property(nonatomic,strong) NSArray<TimerInfo *>* timerList;

-(id)initWithDevid:(NSString*)devid TimerList:(NSArray*)timerList;

@end
