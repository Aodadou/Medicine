//
//  CMDB6_UnBindPhoneNumberResult.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"

@interface CMDB6_UnBindPhoneNumberResult : ServerCommand
@property(nonatomic,strong) NSString* phoneNumber;
@end
