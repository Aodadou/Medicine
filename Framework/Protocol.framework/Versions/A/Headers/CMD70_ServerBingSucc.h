//
//  CMD72_ServerBingSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///IR key binding successfully. (paired third Step)
@interface CMD70_ServerBingSucc : ServerCommand<APPCommandProto>

///SN
@property(nonatomic,strong) NSString<expose>* sn;

///IR button value: 1~9
@property(nonatomic,strong) NSNumber<expose>* button;

-(id)initWithSN:(NSString*)sn Button:(int)button;

@end
