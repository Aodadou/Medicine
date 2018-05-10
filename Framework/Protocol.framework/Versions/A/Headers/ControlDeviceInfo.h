//
//  ControlDeviceInfo.h
//  Protocol
//
//  Created by chendy on 14-8-15.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "JSONObject.h"
#import "CommonDevice.h"
#import "RawDevice.h"



/// Control device info
@interface ControlDeviceInfo : JSONObject

/// control device state index list
@property(strong,nonatomic) NSArray<NSNumber>* ctrlStaIdx;

/// Device state
@property(strong,nonatomic) CommonDevice* device;

@property(strong,nonatomic) RawDevice* rawDevice;

@property(strong,nonatomic) NSString* mask;

-(instancetype)initWithDevice:(CommonDevice*)device;

-(instancetype)initWithDevice:(CommonDevice *)device CtrlStaIdx:(int)ctrlStaIdx;

-(id)initWithDevice:(CommonDevice*)device ControlStateIndexes:(NSArray*)ctrlStaIdx;

-(id)initWithRawDevice:(RawDevice*)rawDevice Mask:(NSString*)mask;

@end
