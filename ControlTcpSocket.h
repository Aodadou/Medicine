

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "CMDFactory.h"
@interface ControlTcpSocket : NSObject<AsyncSocketDelegate> {
    AsyncSocket *_asynSocket;
    NSData      *oldData;
    NSString    *host;
    NSTimer     *idleTimer;
    NSData      *idleData;
    CMDFactory  *cmdFactory;

}
@property (nonatomic,assign) int mode; //0 控制 1配置 2心跳
- (void)sendData:(NSData*)data;
- (void)closeSocket;
- (void)startToConnectServer:(NSString*)ip;
@end
