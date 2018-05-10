

#import "ControlTcpSocket.h"

#import "Util.h"
#import "SessionManger.h"
#define HARD_URL @"http://211.149.188.69:80/arc/v1.00/code/fwup_160619_cd0002.pdf"
@implementation ControlTcpSocket
- (id)init {
    self = [super init];
    if (self) {
        _asynSocket=[[AsyncSocket alloc]initWithDelegate:self]; //得到udp util
        host = @"";
        idleData = [[NSData alloc]init];
        cmdFactory = [CMDFactory getInstance];
    }
    return self;
}
- (void)startIdleTimer {
    [self cancleIdleTimer];
    if (idleTimer == nil) {
        idleTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(sendIdleData) userInfo:nil repeats:YES];
    }
}
- (void)cancleIdleTimer {
    if (idleTimer != nil) {
        [idleTimer invalidate];
        idleTimer = nil;
    }
}
- (void)startToConnectServer:(NSString*)ip {
    
    if (![ip isEqual:host]) {
        [self closeSocket];
        host = ip;
        [self startToConnectServer:ip];
        return;
    }
    if (_asynSocket.isConnected) {
        return;
    }
    NSError *err = nil;
    NSLog(@"connect to server");
    @try {
        [_asynSocket disconnect];
        if ([ip isEqualToString:@""]) {
            return;
        }
        if (![_asynSocket connectToHost:host onPort:220 withTimeout:10 error:&err])
        {
            NSLog(@"Error: %@",err);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Error: %@",exception.reason);
        
    }
    @finally {
        ;
    }
}
- (void)sendIdleData {
    if (_asynSocket != nil && _asynSocket.isConnected) {
        _mode = 2;
        [self sendData:idleData];
    }
}
- (void)sendData:(NSData*)data {
    if (data == nil) {
        return;
    }
   
    oldData = data;
        
    if (_mode == 1) {
        data = [cmdFactory getBytes:0x0F data:data];
    }else if (_mode == 2){
        data = [cmdFactory getBytes:0xFF data:data];
        _mode = 0;
    }else {
        data = [cmdFactory getBytes:0x09 data:data];
    }
        
    if (_asynSocket.isConnected) {
            //        Byte *bytes = (Byte*)[data bytes];
            ////        for (int i = 0; i < [data length]; i++) {
            //            NSLog(@"senddata[%d]:%x",i,bytes[i]&0xff);
            //        }
        NSLog(@"sendata----------");
        [_asynSocket writeData:data withTimeout:10 tag:-1]; //发送udp
        [_asynSocket readDataWithTimeout:-1 tag:0];
            
    }else {
        [self startToConnectServer:host];
    }

    
    
}

-(void)closeSocket {
    [self cancleIdleTimer];
    host = @"";
    oldData = nil;
    if (_asynSocket != nil) {
        [_asynSocket disconnect];
    
    }
}
- (void)onSocket:(AsyncSocket*)sock willDisconnectWithError:(NSError *)err {
    
}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    [sock readDataWithTimeout:-1 tag:0];
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    [sock readDataWithTimeout:-1 tag:0];
    [self cancleIdleTimer];
     [self startIdleTimer];
    
    if (data == nil) {
        return;
    }
    NSInteger len = [data length];
    if (len < 11 || len >= 60) {
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
    
    if (len == 15) {       //启动连接包
        cmdFactory = [CMDFactory getInstance];
        cmdFactory.keyOne = bytes[11];
        cmdFactory.keyTwo = bytes[12];
        cmdFactory.keyThree = bytes[13];
        cmdFactory.keyFour = bytes[14];
        [self startIdleTimer];
        if (oldData != nil) {
             [self sendData:oldData];
        }
    }
    if (len == 19) {
        cmdFactory = [CMDFactory getInstance];
        cmdFactory.keyOne = bytes[11];
        cmdFactory.keyTwo = bytes[12];
        cmdFactory.keyThree = bytes[13];
        cmdFactory.keyFour = bytes[14];
//
        if (_mode != 1) { //不是配置如果版本不一致，升级固件
//            if ( bytes[17] != HARD_VERSION
//                || bytes[18] != 0x00) {
//                NSData *urlData = [HARD_URL dataUsingEncoding:NSUTF8StringEncoding];
//                SessionManger *sm = [SessionManger shareSessionManger];
//                NSData *macdata = [Util dataFromHexString:sm.currentDevice.id];
//                Byte bys[] ={6+[urlData length],0x08,0x53,0x52,HARD_VERSION,0x00,[urlData length]};
//                NSData *bysdata = [NSData dataWithBytes:&bys length:7];
//                NSMutableData *mutdata = [[NSMutableData alloc]init];
//                [mutdata appendData:macdata];
//                [mutdata appendData:bysdata];
//                [mutdata appendData:urlData];
//                _mode = 0;
//                [self sendData:mutdata];
//            }
        }
        if (oldData != nil) {
            [self sendData:oldData];
        }

    }
    if (len == 48 || len == 52) {       // 控制返回指令
        for (int i =0 ; i < 28; i++) {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i+len-28]&0xff];
            if ([newHexStr length] == 1) {
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            }else {
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:CONTROL_RESULT object:hexStr];
         return;
    }
   
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    [self cancleIdleTimer];
    NSLog(@"disconnect");
}


@end
