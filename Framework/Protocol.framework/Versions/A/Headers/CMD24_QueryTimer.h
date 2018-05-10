//
//  CMD24_QueryTimer.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends a query to a device for all timing tasks
@interface CMD24_QueryTimer : ClientCommand<APPCommandProto>

///Device ID
@property(nonatomic,strong) NSString* devid;

-(id)initWithDevid:(NSString*)devid;

@end
