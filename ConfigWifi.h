

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
@interface ConfigWifi : NSObject<AsyncSocketDelegate> {
    AsyncSocket *_asynSocket;
    NSData *oldData;
}

- (void)sendData:(NSData*)data;
- (void)closeSocket;
@end
