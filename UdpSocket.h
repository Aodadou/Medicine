

#import <Foundation/Foundation.h>
#import "AsyncUdpSocket.h"
#import <Protocol/Protocol.h>
@interface UdpSocket : NSObject {

    AsyncUdpSocket *_sersocket;
   
}
+(UdpSocket*)getInstance;
- (void)startToListener;
- (void)stopListener;
@end
