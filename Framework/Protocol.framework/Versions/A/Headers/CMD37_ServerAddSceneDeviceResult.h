//
//  CMD37_ServerAddSceneDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "SceneDevice.h"
#import "Device.h"

///The server returned the results of adding scenario equipment
@interface CMD37_ServerAddSceneDeviceResult : ServerCommand<APPCommandProto>

///Success or not
@property(nonatomic,assign) BOOL result;

///Scenario equipment
@property(nonatomic,strong) SceneDevice* scenedev;

///Device status information
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithResult:(BOOL)result Scenedev:(SceneDevice*)scenedev Ctrlinfo:(Device*)ctrlinfo;

@end
