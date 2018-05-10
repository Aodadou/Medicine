//
//  Device.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"



///All device extends this
@interface Device : JSONObject

///device type
@property(nonatomic,assign) int type;

///device category
@property(nonatomic,assign) int category;

///device id
@property(nonatomic,strong) NSString* id;

///device pid
@property(nonatomic,strong) NSString* pid;

///device name
@property(nonatomic,strong) NSString* name;

///device location
@property(nonatomic,strong) NSString* place;

///device version
@property(nonatomic,assign) int version;

///device network status
@property(nonatomic,assign) BOOL online;

///Device's icon version
@property(assign,nonatomic) int iconVer;

///Device's icon URL
@property(strong,nonatomic) NSString *iconUrl;

@property(assign,nonatomic) BOOL center;

@end
