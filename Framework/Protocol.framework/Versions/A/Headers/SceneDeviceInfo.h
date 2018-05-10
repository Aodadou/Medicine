//
//  SceneDeviceInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"
#import "SceneDevice.h"
#import "Device.h"



///Information about scene device and device information
@interface SceneDeviceInfo : JSONObject

///scene device
@property(nonatomic,strong) SceneDevice* scenedev;

///device info
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithSceneDev:(SceneDevice*)scenedev_ CtrlInfo:(Device*)ctrlinfo_;

@end
