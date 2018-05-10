//
//  CMD23_ServerDelTimerResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerTask.h"

///The server returned the results of deleting the scheduled task
@interface CMD23_ServerDelTimerResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Scheduled information
@property(nonatomic,strong) TimerTask* schedinfo;

-(id)initWithResult:(BOOL)result Schedinfo:(TimerTask*)schedinfo;

@end
