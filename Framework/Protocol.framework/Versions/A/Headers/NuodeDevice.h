//
//  NuodeDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "Device.h"
#import "NuodeDeviceStatus.h"

typedef  enum {
    //Power switch command
    CODE_SWITCH = 0x0A,
    //RGB switching mode
    CODE_RGB = 0x0B,
    //Brightness adjustment command
    CODE_LIGHT = 0x0C,
    //Direct color mode
    CODE_RGB_CW = 0x0D,
    //Heating and light adjustment command
    CODE_CW = 0x0E,
    //RGB Auto Mode Speed ​​Control Command
    CODE_SPEED = 0x0F,
    //Scene mode
    CODE_SCENE = 0x10,
    //Query power status
    CODE_QUERY = 0xA0,
    //WIFI host request to the server to download the list of lights
    CODE_QUERY_SN_LIST = 0xAA,
    //WIFI host requests query list version
    CODE_QUERY_SN_LIST_VERSION = 0xAB,
    //Setting hanging device
    CODE_SN_LIST = 0xAC,
    
} NuodeDeviceControlType;

@interface NuodeDevice : Device

/**
 * control type <br>
 * CODE_SWITCH = 0x0A; // Power switch command <br>
 * CODE_RGB = 0x0B; // RGB switching mode <br>
 * CODE_LIGHT = 0x0C; // Brightness adjustment command<br>
 * CODE_RGB_CW = 0x0D; // Direct color mode <br>
 * CODE_CW = 0x0E; // Heating and light adjustment command <br>
 * CODE_SPEED = 0x0F; // RGB Auto Mode Speed ​​Control Command <br>
 * CODE_SCENE = 0x10; // Scene mode <br>
 * CODE_QUERY = (byte) 0xA0; // Query power status <br>
 * CODE_QUERY_SN_LIST = (byte) 0xAA; // WIFI host request to the server to
 * download the list of lights <br>
 * CODE_QUERY_SN_LIST_VERSION = (byte) 0xAB; // WIFI host requests query
 * list version <br>
 * CODE_SN_LIST = (byte) 0xAC; // Setting hanging device<br>
 */
@property(nonatomic,assign) NuodeDeviceControlType controlType;

///Power status[true:On, false:Off]
@property(nonatomic,assign) BOOL kg;

///R value of RGB: 0~255
@property(nonatomic,strong) NSString* r1;

///G value of RGB: 0~255
@property(nonatomic,strong) NSString* g1;

///B value of RGB: 0~255
@property(nonatomic,strong) NSString* b1;

///RBG level
@property(nonatomic,strong) NSString* rgb2;


///Change speed: 0~6
@property(nonatomic,strong) NSString* speed;

///EL value: 0~100
@property(nonatomic,strong) NSString* c1;

///Warm value: 0~100
@property(nonatomic,strong) NSString* w1;

///CW level
@property(nonatomic,strong) NSString* cw2;

///Brightness: 0~100
@property(nonatomic,strong) NSString* light;

/**
 * Group number<br>
 * null:control of a single hanging device, >=0: control group
 */
@property(nonatomic,strong) NSString* groupNum;


///Scene modes (HexString)
@property(nonatomic,strong)NSString* scene;

///Product Code
@property(nonatomic,strong) NSString* productCode;

///Device status
@property(nonatomic,strong) NuodeDeviceStatus* nuodeStatus;

@end
