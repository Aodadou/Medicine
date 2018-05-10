//
//  CMD6C_ControlIRDeviceMode.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"


///Set IR Device working mode
@interface CMD6C_ControlIRDeviceMode : ClientCommand<APPCommandProto>


///SN
@property(nonatomic,strong) NSString<expose>* sn;


/**
 * Mode
 * 0:Control mode, 1:IR mode
 */
@property(nonatomic,strong) NSNumber<expose>* mode;

-(id)initWithSN:(NSString*)sn Mode:(int)mode;

@end
