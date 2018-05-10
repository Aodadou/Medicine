//
//  CMD36_AddSceneDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "SceneDevice.h"
#import "Device.h"

///The client sends adding scenario Equipment
@interface CMD36_AddSceneDevice : ClientCommand<APPCommandProto>

///Scenario equipment
@property(nonatomic,strong) SceneDevice* scenedev;

///Device status
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithScenedev:(SceneDevice*)scenedev Ctrlinfo:(Device*)ctrlinfo;

@end
