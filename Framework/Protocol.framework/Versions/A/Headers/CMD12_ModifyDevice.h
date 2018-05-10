//
//  CMD12_ModifyDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends commands to modify a device
@interface CMD12_ModifyDevice : ClientCommand<APPCommandProto>

///Device ID
@property(nonatomic,strong) NSString* devid;

///The name you want to change
@property(nonatomic,strong) NSString* name;

///The placement you want to change
@property(nonatomic,strong) NSString* place;

-(id)initWithDevid:(NSString*)devid Name:(NSString*)name Place:(NSString*)place;

@end
