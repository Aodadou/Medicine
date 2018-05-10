//
//  CMDB9_GetVerificationCode.h
//  Protocol
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import <Protocol/Protocol.h>

@interface CMDB9_GetVerificationCode : ClientCommand

@property(nonatomic,strong) NSString* phone;
@property(nonatomic,assign) int action;//action = 0时代表解除绑定 action = 1时代表绑定
-(id)initWithphone:(NSString*)phone Action:(int)act;
@end
