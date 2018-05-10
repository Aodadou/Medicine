//
//  DCMD02_DeviceUpState.h
//  Protocol
//
//  Created by chendy on 14-7-14.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DClientCommand.h"
#import "DeviceInfo.h"

/**
 * Hanging device batch upload status (no request).<br>
 * DCommand No. 02
 */
@interface DCMD02_DeviceUpState : DClientCommand<DCommandProto>

/// Batch of hanging device state
@property(strong,nonatomic) NSArray<DeviceInfo *>* infos;

-(id)initWithInfos:(NSArray*)infos;

@end
