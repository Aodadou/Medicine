//
//  Status.h
//  ClientProtocol
//
//  Created by chendy on 13-10-15.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"



///Nuode hanging device status
@interface NuodeHangingDevice : JSONObject

///Name
@property(nonatomic,strong) NSString* name;

///Product code
@property(nonatomic,strong) NSString* productCode;

///Group number
@property(nonatomic,strong) NSString* group;

///Group name
@property(nonatomic,strong) NSString* groupName;

///Power status
@property(nonatomic,strong) NSString* status;

-(id)initWithName:(NSString*)name ProductCode:(NSString*)productCode Group:(NSString*)groupNum GroupName:(NSString*)groupName Status:(NSString*)status;

@end
