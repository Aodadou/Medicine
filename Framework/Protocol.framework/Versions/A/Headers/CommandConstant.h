//
//  CommandConstant.h
//  Protocol
//
//  Created by chendy on 14-6-23.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#define PROTO_VER @"2.0.0";

/// APP protocol version
static const Byte APP_PROTOCOL_VER = 0x0;

/// APP protocol version
static const Byte DEVICE_PROTOCOL_VER = 0x0;

/// UDP protocol version
static const Byte UDP_PROTOCOL_VER = 0x0;

/// Device protocol header
static const Byte DEVICE_PROTOCOL_HEADER[] = {0xFF,0xFF};

/// App protocol header
static const Byte APP_PROTOCOL_HEADER[] = {0xAA,0xAA};

/// Udp protocol header
static const Byte UDP_PROTOCOL_HEADER[] = {0xEE,0xEE};