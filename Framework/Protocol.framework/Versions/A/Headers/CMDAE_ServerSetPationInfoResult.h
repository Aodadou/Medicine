//
//  CMDAE_ServerSetPationInfoResult.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "PationInfo.h"
@interface CMDAE_ServerSetPationInfoResult : ServerCommand
@property(nonatomic,strong) PationInfo *pationInfo;
@end
