

#import <Foundation/Foundation.h>
#import "OneShotConfig.h"
#import "AsyncUdpSocket.h"
@class SmartConfig1;
@protocol SmartConfigDelegate <NSObject>
@required
- (void)configSuccess:(NSString *)mac host:(NSString *)host;
- (void)configFailed;
@end
@interface SmartConfig1 : NSObject {
    NSString *macAddress;
    NSString *ip;
    OneShotConfig *communication;
    AsyncUdpSocket *_sersocket;

    NSString *_wifiName;
    NSString *wifiPas;
    BOOL isStopConfig;
}

@property (nonatomic,retain) id<SmartConfigDelegate> delegate;
- (void)startConfig:(NSString*)wifiName wifiPas:(NSString*)password;
- (void)stopConfig;
+ (SmartConfig1 *)getInstance;
@end
