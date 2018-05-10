//
//  CMD54_ControlDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends control commands, compatible with other protocols
@interface CMD54_ControlDevice : ClientCommand<APPCommandProto>

///MAC
@property(nonatomic,strong) NSString<expose>* mac;

///SN number
@property(nonatomic,strong) NSString<expose>* sn;

///Hex String
@property(nonatomic,strong) NSString<expose>* hexstr;

-(id)initWithMac:(NSString*)mac SN:(NSString*)sn Hexstr:(NSString*)hexstr;

@end
