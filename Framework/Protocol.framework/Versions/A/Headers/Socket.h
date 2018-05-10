//
//  Socket.h
//  ClientProtocol
//
//  Created by chendy on 13-9-15.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDAsyncSocket;

@class Socket;
@protocol SocketDelegate<NSObject>

@optional
//socket连接成功
-(void)socket:(Socket*)socket didConnectToHost:(NSString *)host port:(uint16_t)port;
//socket断开
-(void)socketDidDisconnect:(Socket*)sock withError:(NSError *)err;
//接收到信息
-(void)socket:(Socket*)socket ReceiveData:(NSData*)data;
//发送指令成功
-(void)socket:(Socket*)socket didWriteDataWithTag:(long)tag;
@end

@interface Socket : NSObject

//ip
@property(nonatomic,strong) NSString* ip;

//端口
@property(nonatomic,assign) int port;

//代理
@property(nonatomic,weak) id<SocketDelegate> delegate;

//TAG
@property(nonatomic,assign) int tag;

//判断网络是否连接
-(BOOL)isConnected;
//建立连接,带超时
-(NSError *)startConnect:(NSTimeInterval)timeOut;
//建立连接
-(NSError *)startConnect;
//关闭连接
-(void)disConnect;
//发送命令
-(void)sendCMDData:(NSData*)cmdData tag:(long)tag;

@end
