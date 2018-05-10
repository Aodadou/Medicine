//
//  CMDB0_ServerReturnAllPationInfo.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "PationInfo.h"
@interface CMDB0_ServerReturnAllPationInfo : ServerCommand
@property(nonatomic,strong) NSArray<PationInfo*>* pationInfos;
@end
