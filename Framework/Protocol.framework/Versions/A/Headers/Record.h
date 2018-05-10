//
//  Record.h
//  ClientProtocol
//
//  Created by chendy on 14-5-4.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "JSONObject.h"



/// Device state record
@interface Record : JSONObject

///Record value
@property(nonatomic,assign) double value;

///Record time
@property(nonatomic,strong) NSString *time;

-(id)initWithValue:(double)value Time:(NSString*)time;

@end
