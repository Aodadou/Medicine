//
//  CMD90_Object.h
//  ClientProtocol
//
//  Created by chendy on 14-2-12.
//  Copyright (c) 2014 year chendy. All rights reserved.
//

#import "JSONObject.h"
#import "CommandObject.h"

@interface CMD90_Object : JSONObject

@property(nonatomic,strong) CommandObject* queryCMD;

@property(nonatomic,assign) int count;

-(id)initWithQueryCMD:(CommandObject*)queryCMD Count:(int)count;

@end
