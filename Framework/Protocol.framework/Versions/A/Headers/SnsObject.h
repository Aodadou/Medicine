//
//  SnsObject.h
//  Protocol
//
//  Created by chendy on 14-11-3.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "JSONObject.h"



@interface SnsObject : JSONObject

/// Third part(SNS) login id
@property(strong,nonatomic) NSString* snsId;

/// Third part(SNS) login type
@property(assign,nonatomic) int snsType;

-(instancetype)initWithSnsId:(NSString*)snsId SnsType:(int)snsType;

@end
