//
//  PushCMDHelper.m
//  MedicineBox
//
//  Created by 吴杰平 on 2017/7/5.
//  Copyright © 2017年 jxm. All rights reserved.
//

#import "PushCMDHelper.h"
#import <Protocol/CMDHelper.h>
#import "SessionManger.h"

@implementation PushCMDHelper{

    CMDHelper *helper;
    
    NSTimer *timer;
    
}




- (instancetype)init{

    if (self = [super init]){
        
        helper = [CMDHelper shareInstance];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connect:) name:kSocketConnect object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close:) name:kSocketClose object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCMD:) name:kReceiveCMD object:nil];
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(becomeActivity:) name:UIApplicationDidBecomeActiveNotification object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackGround:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    }
    return self;
}


- (void)startConnect{
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(closeSocket) userInfo:nil repeats:NO];
    //[CMDHelper setupConnectionWithIp:HOST Port:PUSHPORT withTimeOut:10];
}

- (void)sendCMD73{
    
    [self startConnect];
    
}

- (void)connect:(NSNotification *)notification{
    
    NSLog(@"PushScoket已连接");
    
    NSString *appkey = [NSString stringWithFormat:@"%@:%@",[[[UIDevice currentDevice] identifierForVendor] UUIDString],self.deviceToken];
    

    CMD73_SetParameter *cmd73 = [[CMD73_SetParameter alloc] initWithAPPID:1 Locale:@"cn" Platform:@"i" DeviceToke:appkey EnablePush:YES APPVer:APPVersion];
    
    
    [helper sendCMD:cmd73];
    
    
}


- (void)close:(NSNotification *)notification{
    
    NSLog(@"PushScoket已关闭");
    
}


- (void)closeSocket{

    [helper close];
    
    [timer invalidate];
    
    
    
    //[CMDHelper setupConnectionWithIp:HOST Port:PORT withTimeOut:10];
}




@end
