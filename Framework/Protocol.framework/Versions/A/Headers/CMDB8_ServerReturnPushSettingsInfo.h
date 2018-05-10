//
//  CMDB8_ServerReturnPushSettingsInfo.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"

@interface CMDB8_ServerReturnPushSettingsInfo : ServerCommand

@property(nonatomic,assign) BOOL weChatPush;
@property(nonatomic,strong) NSArray *bindPhoneList;

@end
