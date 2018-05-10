//
//  CMD35_ServerQuerySceneListResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns a list of profile
@interface CMD35_ServerQuerySceneListResult : ServerCommand<APPCommandProto>

///Scenario List
@property(nonatomic,strong) NSArray* sceneList;

-(id)initWithSceneList:(NSArray*)sceneList;

@end
