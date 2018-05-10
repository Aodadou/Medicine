//
//  CMDBA_ServerReturnVerificationCode.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"

@interface CMDBA_ServerReturnVerificationCode : ServerCommand

@property(nonatomic,strong) NSString* uuid;

@end
