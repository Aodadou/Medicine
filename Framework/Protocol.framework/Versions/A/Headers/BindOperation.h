//
//  BindOperation.h
//  Protocol
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "JSONObject.h"

@interface BindOperation : JSONObject
@property(nonatomic,strong) NSString *phoneNo;
@property(nonatomic,strong) NSString *verificationCode;
@property(nonatomic,strong) NSString *uuid;
@end
