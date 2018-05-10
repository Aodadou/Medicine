//
//  CMDHelper.h
//  ClientProtocol
//
//  Created by chendy on 13-9-15.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerCommand.h"
#import "ClientCommand.h"
#import "CommonDevice.h"

///Notify receive command
#define kReceiveCMD @"kReceiveCMD"
///Notify socket connected
#define kSocketConnect @"kSocketConnect"
///Notify socket disconnect
#define kSocketClose @"kSocketClosed"
///Notify write socket succ
#define kSocketWriteSucc @"kSocketWriteSucc"

@class CMDHelper;

@protocol CMDHelperDelegate<NSObject>

@optional
///Socket connected with tag
-(void)CMDHelper:(CMDHelper*)helper socketConnectedWithTag:(int)tag;
///Socket disconnected with tag
-(void)CMDHelper:(CMDHelper*)helper socketClosedWithTag:(int)tag;
///Receive a server command
-(void)CMDHelper:(CMDHelper*)helper receiveCMD:(ServerCommand*)cmd;
///Write data succ
-(void)socketWriteSucc;
///Parse device
-(CommonDevice*)CMDHelper:(CMDHelper*)helper parseDeviceWithSn:(NSString*)sn Type:(int)type State:(NSString*)state;
@end

/**
 * Client Command Helper, as a helper to communicate with server
 * Help to send command to server and receive command from the server
 */
@interface CMDHelper : NSObject

///Server ip
@property(nonatomic,strong,readonly) NSString* ip;

///Server port
@property(nonatomic,assign,readonly) int port;

@property(nonatomic,weak) id<CMDHelperDelegate> delegate;

+(id)setupConnectionWithIp:(NSString*)ip Port:(int)port;

+(id)setupConnectionWithIp:(NSString*)ip Port:(int)port withTimeOut:(NSTimeInterval)timeout;

+(id)shareInstance;

-(BOOL)isConnected;

///Setup connection and set tag to 0
-(NSError *)connect;
///Setup connection with tag
-(NSError *)connectWithTag:(int)tag;
///Setup connection with tag and timeout
-(NSError *)connect:(NSTimeInterval)timeout;

-(void)close;
///Close connection and set tag
-(void)closeWithTag:(int)tag;
///Send a command
-(void)sendCMD:(ClientCommand*)cmd;

@end
