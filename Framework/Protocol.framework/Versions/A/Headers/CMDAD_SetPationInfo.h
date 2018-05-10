//
//  CMDAD_SetPationInfo.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"
#import "PationInfo.h"
@interface CMDAD_SetPationInfo : ClientCommand
@property(nonatomic,strong) PationInfo *pationInfo;

-(id)initWithPationInfo:(PationInfo*)info;
@end
