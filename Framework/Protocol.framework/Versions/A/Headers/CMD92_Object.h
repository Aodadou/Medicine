//
//  CMD92_Object.h
//  ClientProtocol
//
//  Created by chendy on 14-2-12.
//  Copyright (c) 2014 year chendy. All rights reserved.
//

#import "JSONObject.h"
#import "CommandObject.h"

@interface CMD92_Object : JSONObject

@property(nonatomic,strong) CommandObject* queryCMD;

@property(nonatomic,assign) int offset;

@property(nonatomic,assign) int length;

@property(nonatomic,strong) CommandObject* resultCMD;

-(id)initWtihQueryCMD:(CommandObject*)queryCMD Offset:(int)offset Length:(int)length ResultCMD:(CommandObject*)resultCMD;

@end
