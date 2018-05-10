

#import "ConfigWifi.h"
#import "CMDFactory.h"
@implementation ConfigWifi
- (id)init {
    self = [super init];
    if (self) {
        _asynSocket=[[AsyncSocket alloc]initWithDelegate:self];
    }
    return self;
}
- (void)startToConnectServer {
    if (_asynSocket == nil) {
        _asynSocket=[[AsyncSocket alloc]initWithDelegate:self];
    }
    
    NSError *err = nil;
    NSLog(@"connect to server");
    @try {
        [_asynSocket disconnect];
        

        if (![_asynSocket connectToHost:@"192.168.1.100" onPort:220 withTimeout:1 error:&err])
        {
            NSLog(@"Error: %@",err);
        }
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        ;
    }
}
- (void)sendData:(NSData*)data {
    if (data == nil) {
        return;
    }
    oldData = data;
    CMDFactory *cmdFactory = [CMDFactory getInstance];
    data =  [cmdFactory getBytes:0x11 data:data];
        if (_asynSocket.isConnected) {
        [_asynSocket writeData:data withTimeout:10 tag:-1]; //发送udp
        [_asynSocket readDataWithTimeout:-1 tag:0];
    }else {
        [self startToConnectServer];
    }
    
}

-(void)closeSocket {
    if (_asynSocket != nil) {
        [_asynSocket disconnect];
        _asynSocket = nil;
    }
}
- (void)onSocket:(AsyncSocket*)sock willDisconnectWithError:(NSError *)err {
    
}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    [sock readDataWithTimeout:-1 tag:0];
    
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    [sock readDataWithTimeout:-1 tag:0];
    int len = [data length];
    if (len < 11 || len >= 50) {
        return;
    }
    Byte *bytes = (Byte*)[data bytes];
    if (bytes[0] != 0xFF || bytes[1] != 0xFF) {
        return;
    }
    NSString *hexStr = @"";
    if (bytes[10] == 0x10) {  // 配置返回
        hexStr = [NSString stringWithFormat:@"%d",bytes[11]&0xff];
        [[NSNotificationCenter defaultCenter]postNotificationName:CONFIG_STATUS object:hexStr];
        return;
    }
    if (len == 19) {       //启动连接包
        CMDFactory *cmdFactory = [CMDFactory getInstance];
        cmdFactory.keyOne = bytes[11];
        cmdFactory.keyTwo = bytes[12];
        cmdFactory.keyThree = bytes[13];
        cmdFactory.keyFour = bytes[14];
        [self sendData:oldData];
    }
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSLog(@"disconnect");
}


@end
