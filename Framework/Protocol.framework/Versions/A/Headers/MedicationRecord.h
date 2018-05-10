//
//  MedicationRecord.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "JSONObject.h"

@interface MedicationRecord : JSONObject
@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* takingTime;
@property(nonatomic,assign) int situation;
@property(nonatomic,strong) NSString* macAddr;

-(id)initWithName:(NSString*)name TakingTime:(NSString*)takeingTime Situation:(int)situation MacAddr:(NSString *)mac;

@end
