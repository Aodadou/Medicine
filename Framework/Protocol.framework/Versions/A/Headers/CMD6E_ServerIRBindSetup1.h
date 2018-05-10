//
//  CMD70_ServerIRBindSetup1.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///IR key binding step 1. (paired first Step)
@interface CMD6E_ServerIRBindSetup1 : ServerCommand<APPCommandProto>

///SN
@property(nonatomic,strong) NSString<expose>* sn;

-(id)initWithSN:(NSString*)sn;

@end
