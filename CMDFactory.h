
#import <Foundation/Foundation.h>
#define CONFIG_STATUS @"configWIFI"
#define RECEIVE_KEY   @"receiveKey"
#define CONTROL_RESULT @"controlResult"
@interface CMDFactory : NSObject
@property (nonatomic,assign) int keyOne;
@property (nonatomic,assign) int keyTwo;
@property (nonatomic,assign) int keyThree;
@property (nonatomic,assign) int keyFour;
+ (CMDFactory*)getInstance;
- (NSMutableData*)getBytes:(int)cmd data:(NSData*)data;
@end
