//
//  DrugTimeScheme.h
//  Protocol
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "JSONObject.h"
#import "SchemeTime.h"
@interface DrugTimeScheme : JSONObject

@property (nonatomic,strong) NSString* rfid;
@property (nonatomic,assign) int cycle;
@property (nonatomic,assign) int prompTone;
@property (nonatomic,strong) NSString* beginDay;
@property (nonatomic,strong) NSString* endDay;
@property(nonatomic,strong) NSArray<SchemeTime *>*schemeList;
-(id)initRfid:(NSString*)rfid Cycle:(int)cycle PrompTone:(int)prompTone BeginDay:(NSString*)beginDay EndDay:(NSString*)enday SchemeList:(NSArray<SchemeTime *>*)schemelist;
@end
