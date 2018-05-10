//
//  CMD92_ServerRetrunSubList.h
//  ClientProtocol
//
//  Created by chendy on 14-2-12.
//  Copyright (c) 2014 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "ClientCommand.h"

///The server returns sub-list
@interface CMD92_ServerRetrunSubList : ServerCommand<APPCommandProto>

/**
 * Query command<br>
 * Instance of CMD04、CMD24、CMD2C、CMD34、CMD3C、CMD83、CMD8B class.
 */
@property(nonatomic,strong) ClientCommand* queryCMD;

///Offset from the start of list
@property(nonatomic,assign) int offset;

///The need to obtain the length of the list
@property(nonatomic,assign) int length;

/**
 * Result command<br>
 * Instance of CMD05、CMD25、CMD2D、CMD35、CMD3D、CMD84、CMD8C class.
 */
@property(nonatomic,strong) ServerCommand* resultCMD;

-(id)initWtihQueryCMD:(ClientCommand*)queryCMD Offset:(int)offset Length:(int)length ResultCMD:(ServerCommand*)resultCMD;

@end
