//
//  CMD01_ServerLoginPermit.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server return login permission
@interface CMD01_ServerLoginPermit : ServerCommand<APPCommandProto>

///License Key
@property(nonatomic,strong) NSString* key;

-(id)initWithKey:(NSString*)key;

@end
