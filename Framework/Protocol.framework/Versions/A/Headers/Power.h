//
//  Power.h
//  NewProtocol
//
//  Created by chendy on 13-9-5.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"


///Power state info
@interface Power : JSONObject

///the way of plug
@property(nonatomic,assign) int way;

///power status
@property(nonatomic,assign) BOOL on;

-(id)initWithWay:(int)way_ On:(BOOL)on_;

@end
