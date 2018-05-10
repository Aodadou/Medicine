//
//  CMD90_ServerRetrunListCount.h
//  ClientProtocol
//
//  Created by chendy on 14-2-12.
//  Copyright (c) 2014 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "ClientCommand.h"

///The server returns total number of a list
@interface CMD90_ServerRetrunListCount : ServerCommand<APPCommandProto>

/**
 * Query command<br>
 * Instance of CMD04、CMD24、CMD2C、CMD34、CMD3C、CMD83、CMD8B class.
 */
@property(nonatomic,strong) ClientCommand* queryCMD;

///List size
@property(nonatomic,assign) int count;

-(id)initWithQueryCMD:(ClientCommand*)queryCMD Count:(int)count;

@end
