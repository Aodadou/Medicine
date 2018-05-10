

#import "UdpSocket.h"
#import "MyGlobalData.h"

static UdpSocket *instance;
@implementation UdpSocket
+(UdpSocket*)getInstance {
    if (instance == nil) {
        instance = [[UdpSocket alloc]init];
    }
    return instance;
}
- (id)init {
    self = [super init];
    if (self) {
        

    }
    return self;
}
- (void)startToListener {
//    if (isRunning) {
//        return;
//    }
    [self initSocket];
//    [self performSelectorInBackground:@selector(initSocket) withObject:nil];
    
}
- (void)initSocket {
    if (_sersocket == nil) {
//        isRunning = YES;
        _sersocket =  [[AsyncUdpSocket alloc] initWithDelegate:self];
        [_sersocket bindToPort:50003 error:nil];
        [_sersocket receiveWithTimeout:-1 tag:0];
    }
}
- (void)stopListener {
    if (_sersocket != nil) {
//        isRunning = NO;
        [_sersocket close];
        [_sersocket setDelegate:nil];
        _sersocket = nil;
    }
}
//下面是发送的相关回调函数
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
    [sock receiveWithTimeout:-1 tag:0];
    if ([host hasPrefix:@"::"] || [host hasPrefix:@"ff"]) {
        return YES;
    }
    NSInteger len = [data length];
    int prex = [[host substringWithRange:NSMakeRange(0,3)] intValue];
    if (prex >= 256 || prex < 1) {
        return YES;
    }
    if (len != 32) {
        return YES;
    }
    Byte *bytes = (Byte*)[data bytes];
    if (bytes[3] != len) {
        return YES;
    }
    if (bytes[0] != 0xEE
        || bytes[1] != 0xEE
        || bytes[2] != 0x00
        || bytes[28] != 0x53
        || bytes[29] != 0x52) {
        return YES;
    }
    NSString *hexStr = @"";
    for (int i = 11 ; i < 17; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];
        if ([newHexStr length] == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }else {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    hexStr = [hexStr uppercaseString];
    NSString *mac = hexStr;
    
    hexStr = @"";
    for (int i = 22 ; i < 28; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];
        if ([newHexStr length] == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }else {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    NSString *apmac = hexStr;
    apmac = [apmac uppercaseString];
    BOOL hasChanged = NO;
//    for (int i = 0;i < [MyGlobalData getDeviceList].count; i++) {
//        TranDevice *device = [[MyGlobalData getDeviceList] objectAtIndex:i];
//        if ([device.id isEqualToString:[NSString stringWithFormat:@"00%@",mac]]) {
//         
//            if (device.netinfo != nil) {
//                if (![device.netinfo.devip isEqualToString:host]) {
//                    device.netinfo.natip = host;
//                    device.netinfo.apmac = apmac;
//                    hasChanged = YES;
//                }
//            }else {
//                hasChanged = YES;
//                device.netinfo = [[NetInfo alloc]initWithId:device.id ApMac:apmac devip:host natip:@"" iscenter:NO];
//            }
//            if (!device.online) {
//                device.online = YES;
//                hasChanged = YES;
//            }
//
//            [[MyGlobalData getDeviceList] replaceObjectAtIndex:i withObject:device];
//            if (hasChanged) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"broast" object:nil];
//
//            }
//            break;
//        }
//    }
       return YES;
}
-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    NSLog(@"didNotSendDataWithTag----");
    
}
-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error{
    NSLog(@"didNotReceiveDataWithTag----");
}
-(void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    NSLog(@"didSendDataWithTag----");
}
-(void)onUdpSocketDidClose:(AsyncUdpSocket *)sock{
    NSLog(@"onUdpSocketDidClose----");
}


@end
