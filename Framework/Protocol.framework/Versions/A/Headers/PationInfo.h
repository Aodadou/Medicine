//
//  PationInfo.h
//  Protocol
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 fortune. All rights reserved.
//

#import "JSONObject.h"

@interface PationInfo : JSONObject
@property(nonatomic,strong) NSString *macId;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *purpose;
@property(nonatomic,strong) NSString *region;
@property(nonatomic,strong) NSString* avatarUrl;
@property(nonatomic,assign) int gender;

-(id)initWithMacId:(NSString*)macId Name:(NSString*)name AvatarUrl:(NSString*)avatarUrl Gender:(int)gender Birthday:(NSString*)birthday Region:(NSString*)region Purpose:(NSString*)purpose;

@end
