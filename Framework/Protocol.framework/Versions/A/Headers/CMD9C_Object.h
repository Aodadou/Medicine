//
//  CMD9C_Object.h
//  ClientProtocol
//
//  Created by chendy on 14-6-30.
//  Copyright (c) 2014年 chendy. All rights reserved.
//

#import "JSONObject.h"

@interface CMD9C_Object : JSONObject

/// Device MAC address
@property(nonatomic,strong) NSString *mac;

/// City name
@property(nonatomic,strong) NSString* city;

/// PM2.5 value
@property(nonatomic,assign) double PM25;

/// temperature
@property(nonatomic,assign) double temperature;

/// humidity
@property(nonatomic,assign) double humidity;

/// Cold grade
@property(nonatomic,assign) double coldGrade;

/// Air quality
@property(nonatomic,strong) NSString* airQuality;

/// Weather infomation
@property(nonatomic,strong) NSString* weather;

-(id)initWithMac:(NSString*)mac City:(NSString*)city PM25:(double)pm25 Temperature:(double)temperature Humidity:(double)Humidity ColdGrade:(double)coldGrade AirQuality:(NSString*)airQuality Weather:(NSString *)weather;

@end
