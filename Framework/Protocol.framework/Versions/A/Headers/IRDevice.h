//
//  IRDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-15.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "CommonDevice.h"
#import "Power.h"

///IR device
@interface IRDevice : CommonDevice

///power status
@property(nonatomic,strong) NSArray<Power*>* powerList;

///Deprecated
@property(nonatomic,strong) NSNumber* switchNum DEPRECATED_ATTRIBUTE;

/**
 * work mode
 * 0: control mode, 1: study mode
 */
@property(nonatomic,strong) NSString* mode;

///button value
@property(nonatomic,strong) NSString* key;

///set first power way status
-(void)setOneWayPower:(BOOL)on;

///get first power way status
-(BOOL)getOneWayPower;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)online Power:(NSArray*)powers Mode:(NSString*)mode Key:(NSString*)key;

-(id)initWithMode:(NSString*)mode Key:(NSString*)key;

@end
