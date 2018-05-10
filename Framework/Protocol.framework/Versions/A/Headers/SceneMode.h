//
//  SceneMode.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"



///Scene mode object
@interface SceneMode : JSONObject

///16bytes GUID
@property(nonatomic,strong) NSString* id;

///Image No.
@property(nonatomic,assign) int imageno;

///name
@property(nonatomic,strong) NSString* name;

-(id)initWithId:(NSString*)id_ ImageNo:(int)imageno_ Name:(NSString*)name_;

@end
