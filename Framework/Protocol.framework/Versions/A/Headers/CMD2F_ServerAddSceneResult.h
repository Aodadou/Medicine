//
//  CMD2F_ServerAddSceneResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "SceneMode.h"

///The server returned the results of adding profile
@interface CMD2F_ServerAddSceneResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Profiles
@property(nonatomic,strong) SceneMode* scene;

-(id)initWithResult:(BOOL)result Scene:(SceneMode*)scene;

@end
