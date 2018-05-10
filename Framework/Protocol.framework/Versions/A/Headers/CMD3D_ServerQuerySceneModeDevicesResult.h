//
//  CMD3D_ServerQuerySceneModeDevicesResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returned scenario equipment list
@interface CMD3D_ServerQuerySceneModeDevicesResult : ServerCommand<APPCommandProto>

///Scenario device list
@property(nonatomic,strong) NSArray* sceneDeviceList;

-(id)initWithSceneDevices:(NSArray*)sceneDeviceList;

@end
