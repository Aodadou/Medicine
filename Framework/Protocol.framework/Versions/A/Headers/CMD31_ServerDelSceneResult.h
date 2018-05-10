//
//  CMD31_ServerDelSceneResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returned the results of deleting profile
@interface CMD31_ServerDelSceneResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Profile ID
@property(nonatomic,strong) NSString* sceneid;

-(id)initWithResult:(BOOL)result Sceneid:(NSString*)sceneid;

@end
