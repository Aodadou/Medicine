//
//  CMD8F_QueryListCount.h
//  ClientProtocol
//
//  Created by chendy on 14-2-12.
//  Copyright (c) 2014 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///Query a list size
@interface CMD8F_QueryListCount : ClientCommand<APPCommandProto>

/**
 * Query command<br>
 * Instance of CMD04、CMD24、CMD2C、CMD34、CMD3C、CMD83、CMD8B class.
 */
@property(nonatomic,strong) ClientCommand* queryCMD;

-(id)initWithQueryCMD:(ClientCommand*)queryCMD;

@end
