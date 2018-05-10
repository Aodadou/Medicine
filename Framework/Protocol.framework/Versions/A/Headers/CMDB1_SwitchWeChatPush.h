//
//  CMDB1_SwitchWeChatPush.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//


#import "ClientCommand.h"

@interface CMDB1_SwitchWeChatPush : ClientCommand
@property(nonatomic,assign) BOOL switchState;
-(id)initWithState:(BOOL)state;
@end
