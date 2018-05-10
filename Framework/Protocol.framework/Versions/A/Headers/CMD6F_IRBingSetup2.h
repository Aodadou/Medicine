//
//  CMD71_IRBingSetup2.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///IR key binding step 2. (paired second Step)
@interface CMD6F_IRBingSetup2 : ClientCommand<APPCommandProto>

///SN
@property(nonatomic,strong) NSString<expose>* sn;

///IR button: 1~9
@property(nonatomic,strong) NSNumber<expose>* button;

-(id)initWithSN:(NSString*)sn Button:(int)button;

@end
