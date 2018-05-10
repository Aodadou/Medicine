//
//  CMDB5_UnBindPhoneNumber.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//


#import "ClientCommand.h"

@interface CMDB5_UnBindPhoneNumber : ClientCommand
@property(nonatomic,strong) NSString*phoneNo;
-(CMDB5_UnBindPhoneNumber*)initWithPhoneNo:(NSString*)phone;
@end
