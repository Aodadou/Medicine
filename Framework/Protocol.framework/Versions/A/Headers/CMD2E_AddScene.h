//
//  CMD2E_AddScene.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "SceneMode.h"

///The client sends the command to add a single profile
@interface CMD2E_AddScene : ClientCommand<APPCommandProto>

///Profiles
@property(nonatomic,strong) SceneMode* scene;

-(id)initWithScene:(SceneMode*)scene;

@end
