//
//  CMD91_QuerySubList.h
//  ClientProtocol
//
//  Created by chendy on 14-2-12.
//  Copyright (c) 2014 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends a query to a list of sub-content
@interface CMD91_QuerySubList : ClientCommand<APPCommandProto>

/**
 *Query command<br>
 *Instance of CMD04、CMD24、CMD2C、CMD34、CMD3C、CMD83、CMD8B class. 
 */
@property(nonatomic,strong) ClientCommand* queryCMD;


///Offset from the start of list
@property(nonatomic,assign) int offset;

///The need to obtain the length of the list
@property(nonatomic,assign) int length;

-(id)initWtihQueryCMD:(ClientCommand*)queryCMD Offset:(int)offset Length:(int)length;


@end
