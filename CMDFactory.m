
#import "CMDFactory.h"

@implementation CMDFactory
static CMDFactory *instance;
+ (CMDFactory*)getInstance {
    if (instance == nil) {
        instance = [[CMDFactory alloc]init];
    }
    return instance;
}

- (NSMutableData*)getBytes:(int)cmd data:(NSData*)data {
    if (nil == data) {
        return nil;
    }
    int len = 11 + (int)[data length];
    
    Byte baseByte[] = {0xFF,0xFF,0x00,len,0x00,0x00,0x00,0x00,0x00,0x00,cmd};
    
    NSData *baseData = [NSData dataWithBytes:&baseByte length:11];
    
    NSMutableData *mutData = [[NSMutableData alloc]init];
    
    [mutData appendData:baseData];
    
    [mutData appendData:data];
    
    Byte *sendBytes = (Byte*)[mutData bytes];
    Byte sum[] = {0x00,0x00,0x00,0x00};
    Byte key[] = {_keyOne,_keyTwo,_keyThree,_keyFour};
    for (int j = 0; j < 4; j++) {
        for (int i = j; i < len; i+=4) {
            sum[j] += sendBytes[i];
        }
    }
    sendBytes[6] = sum[0] + sendBytes[5]+ key[0];
    sendBytes[7] = sum[1] + sendBytes[5]+ key[1] + sendBytes[6];
    sendBytes[8] = sum[2] + sendBytes[5]+ key[2] + sendBytes[7];
    sendBytes[9] = sum[3] + sendBytes[5]+ key[3] + sendBytes[8];
    
    mutData = [[NSMutableData alloc]initWithBytes:sendBytes length:len];
    return mutData;
}

@end
