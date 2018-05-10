//
//  SchemeTime.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "JSONObject.h"

@interface SchemeTime : JSONObject
@property(nonatomic,assign) NSInteger hour;
@property(nonatomic,assign) NSInteger minute;

-(id)initWithHour:(NSInteger)hour Minute:(NSInteger)minute ;

@end
