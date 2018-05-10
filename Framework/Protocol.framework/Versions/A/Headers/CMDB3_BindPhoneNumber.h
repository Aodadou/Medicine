//
//  CMDB3_BindPhoneNumber.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"

@interface CMDB3_BindPhoneNumber : ClientCommand

@property(nonatomic,strong) NSString*phoneNo;
@property(nonatomic,strong) NSString*verificationCode;
@property(nonatomic,strong) NSString*uuid;

-(CMDB3_BindPhoneNumber*)initWithPhone:(NSString*)phone VerificationCode:(NSString*)code Uuid:(NSString*)uuid;
@end
