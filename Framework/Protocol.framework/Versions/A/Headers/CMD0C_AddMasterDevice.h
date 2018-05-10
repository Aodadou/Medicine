//
//  CMD0C_AddMasterDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends commands to add WiFi devices
@interface CMD0C_AddMasterDevice : ClientCommand<APPCommandProto>

///Device password
@property(nonatomic,strong) NSString* password;

///MAC
@property(nonatomic,strong) NSString* mac;

///The name you want to name this device
@property(nonatomic,strong) NSString* name;

///Device placement
@property(nonatomic,strong) NSString* place;

///Device type
@property(nonatomic,assign) int deviceType;

//Switcher attach information
@property(nonatomic,strong) NSString* attach;

-(id)initWithPass:(NSString*)pass Mac:(NSString*)mac Name:(NSString*)name Place:(NSString*)place DeviceType:(int)deviceType;

-(id)initWithPass:(NSString*)pass Mac:(NSString*)mac Name:(NSString*)name Place:(NSString*)place DeviceType:(int)deviceType Attach:(NSString*)attach;

@end
