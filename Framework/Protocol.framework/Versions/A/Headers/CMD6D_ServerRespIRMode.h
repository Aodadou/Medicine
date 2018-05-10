//
//  CMD6D_ServerRespIRMode.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns the device's working mode
@interface CMD6D_ServerRespIRMode : ServerCommand<APPCommandProto>

///SN
@property(nonatomic,strong) NSString<expose>* sn;

/**
 * Mode <br>
 * 0:Control mode, 1:IR mode
 **/
@property(nonatomic,strong) NSNumber<expose>* mode;

-(id)initWithSN:(NSString*)sn Mode:(int)mode;

@end
