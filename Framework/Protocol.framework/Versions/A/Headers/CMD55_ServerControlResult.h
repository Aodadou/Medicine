//
//  CMD55_ServerControlResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server sends the control results, compatible with other protocols
@interface CMD55_ServerControlResult : ServerCommand<APPCommandProto>

///MAC
@property(nonatomic,strong) NSString<expose>* mac;

///SN number
@property(nonatomic,strong) NSString<expose>* sn;

///Hex String
@property(nonatomic,strong) NSString<expose>* hexstr;

-(id)initWithMac:(NSString*)mac SN:(NSString*)sn Hexstr:(NSString*)hexstr;


@end
