//
//  NormalDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-9.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"



/// Common Device
@interface NormalDevice : JSONObject

///device id
@property(nonatomic,strong) NSString* devid;

///vendor identification code
@property(nonatomic,assign) int order;

-(id)initWithDevid:(NSString*)devid_ Order:(int)order_;

@end
