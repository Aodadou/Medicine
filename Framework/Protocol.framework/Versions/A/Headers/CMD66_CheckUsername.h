//
//  CMD66_CheckUsername.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends authentication user name is available
@interface CMD66_CheckUsername : ClientCommand<APPCommandProto>

///User name
@property(nonatomic,strong) NSString<expose>* username;

-(id)initWithUsername:(NSString*)username;

@end
