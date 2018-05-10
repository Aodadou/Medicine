//
//  CMD0E_AddSlaveDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends commands to add 2.4G device
@interface CMD0E_AddSlaveDevice : ClientCommand<APPCommandProto>

///Device password
@property(nonatomic,strong) NSString* password;

///SN number
@property(nonatomic,strong) NSString* sn;

///PID
@property(nonatomic,strong) NSString* pid;

///The name you want to name this device
@property(nonatomic,strong) NSString* name;

///Device placement
@property(nonatomic,strong) NSString* place;

///Device major type
@property(nonatomic,assign) int type;

///Device minor type
@property(nonatomic,strong) NSString* attach;

-(id)initWithPass:(NSString*)pass SN:(NSString*)sn Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Type:(int)type;

-(id)initWithPass:(NSString*)pass SN:(NSString*)sn Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Type:(int)type Attach:(NSString*)attach;

@end
