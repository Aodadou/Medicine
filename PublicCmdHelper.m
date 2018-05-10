//
//  MyCmdHelper.m
//  HomiSmart
//
//  Created by David Huang on 13-11-22.
//  Copyright (c) 2013年 David Huang. All rights reserved.
//

#import "PublicCmdHelper.h"
#import "SessionManger.h"
static PublicCmdHelper* myCmdHelper;

@implementation PublicCmdHelper{
    //保存CMD的字典
    NSMutableDictionary *cmdDic;
    //busy次数
    int busyCount;
    //记录上次发送的是几号cmd
    int lastCMD;
    //当收到09号指令时，不立刻刷新，而是过X秒后再刷新
    NSTimer * reflashCmd09Timer;
    //用来保存前一个cmd09 指令操作的设备Id号
    NSString * saveDeviceId;
    //是否自己操作
    BOOL isManual;
    //是否需要延迟
    BOOL needDelay;
    //要发送的8号指令的队列
    NSMutableArray* cmd8List;
    //队列锁
    NSCondition *cmd8Lock;
}

+(PublicCmdHelper*)sharePublicCmdHelperInstance{
    if (myCmdHelper == nil) {
        myCmdHelper = [[PublicCmdHelper alloc]init];
    }
    return myCmdHelper;
}

-(id)init{
    self = [super init];
    if (self) {
        _helper = [CMDHelper shareInstance];
        cmdDic = [[NSMutableDictionary alloc]init];
        cmd8List = [[NSMutableArray alloc] init];
        cmd8Lock  = [[NSCondition alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCMD:) name:kReceiveCMD object:nil];
        busyCount = 0;
        lastCMD = 0;
        needDelay = NO;
    }
    return self;
}

#pragma mark -
#pragma mark 没做busy处理的指令

-(void)sendCMD00{
    CMD00_ConnectRequet *cmd00 = [[CMD00_ConnectRequet alloc]init];
    [_helper sendCMD:cmd00];
}

-(void)sendCMD02WithUser:(NSString*)user Pass:(NSString*)pass Offset:(int)offset appid:(int)appid{
    CMD02_Login *cmd02 =[[CMD02_Login alloc] initWithUser:user Pass:pass Offset:offset appid:appid];
    [_helper sendCMD:cmd02];
}

-(void)sendCMD04{
    CMD04_GetAllDeviceList *cmd04 = [[CMD04_GetAllDeviceList alloc]init];
    [_helper sendCMD:cmd04];
}

-(void)sendCMD12WithDevid:(NSString*)devid Name:(NSString*)name Place:(NSString*)place{
    CMD12_ModifyDevice *cmd12 = [[CMD12_ModifyDevice alloc]initWithDevid:devid Name:name Place:place];
    [_helper sendCMD:cmd12];
}

//AddTimer
-(void)sendCMD18WithSchedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo{
    CMD18_AddTimerTask *cmd18 = [[CMD18_AddTimerTask alloc]initWithSchedinfo:schedinfo Ctrlinfo:(ControlDeviceInfo*)ctrlinfo];
    [_helper sendCMD:cmd18];
}
//ModifyTimer
-(void)sendCMD20WithSchedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo{
    CMD20_ModifyTimer *cmd20 = [[CMD20_ModifyTimer alloc]initWithSchedinfo:schedinfo Ctrlinfo:(ControlDeviceInfo*)ctrlinfo];
    [_helper sendCMD:cmd20];
}

-(void)sendCMD22WithSchedid:(NSString*)schedid{
    CMD22_DelTimer *cmd22 = [[CMD22_DelTimer alloc]initWithSchedid:schedid];
    [_helper sendCMD:cmd22];
}

-(void)sendCMD24WithDevid:(NSString*)devid{
    CMD24_QueryTimer *cmd24 = [[CMD24_QueryTimer alloc]initWithDevid:devid];
    [_helper sendCMD:cmd24];
}

-(void)sendCMD6CWithSN:(NSString *)sn Mode:(int)mode{
    CMD6C_ControlIRDeviceMode *cmd6c = [[CMD6C_ControlIRDeviceMode alloc]initWithSN:sn Mode:mode];
    [_helper sendCMD:cmd6c];
}

-(void)sendCMD6FWithSN:(NSString *)sn Button:(int)button{
    CMD6F_IRBingSetup2 *cmd6f = [[CMD6F_IRBingSetup2 alloc]initWithSN:sn Button:button];
    [_helper sendCMD:cmd6f];
}

-(void)sendCMD73WithAPPID:(int)appID Locale:(NSString*)locale{
    CMD73_SetParameter *cmd73 = [[CMD73_SetParameter alloc]
                                 initWithAPPID:appID Locale:locale Platform:@"i" DeviceToke:nil EnablePush:NO APPVer:APPVersion];
    [_helper sendCMD:cmd73];
}

-(void)sendCMDFC{
    CMDFC_IdleSucc *cmdfc = [[CMDFC_IdleSucc alloc]init];
    [_helper sendCMD:cmdfc];
}

#pragma mark -
#pragma mark 8号发送指令

-(void)sendCMD08WithStatus:(Device*)status NeedDelay:(BOOL)delay{
    CMD08_ControlDevice *cmd08 = [[CMD08_ControlDevice alloc]initWithDevice:(CommonDevice*)status];
    needDelay = delay;
    isManual = YES;
    saveDeviceId = status.id;
    [self addToCmd8List:cmd08];
}

#pragma mark -
#pragma mark 做了busy处理的指令

-(void)sendCMD0AWithUser:(NSString*) username Pass:(NSString*)password Phone:(NSString*)phone Email:(NSString*)email{
    CMD0A_Register* cmd0a =[[CMD0A_Register alloc] initWithUser:username Pass:password Phone:phone Email:email];
    [_helper sendCMD:cmd0a];
    [cmdDic setObject:cmd0a forKey:RECORD_CMD];
    lastCMD = 10;
    busyCount = 0;
}

-(void)sendCMD0CWithPass:(NSString*)pass MAC:(NSString*)mac Name:(NSString*)name Place:(NSString*)place{
    CMD0C_AddMasterDevice *cmd0c = [[CMD0C_AddMasterDevice alloc]
                                    initWithPass:pass Mac:mac Name:name Place:place DeviceType:airDeviceType];
    [_helper sendCMD:cmd0c];
    [cmdDic setObject:cmd0c forKey:RECORD_CMD];
    lastCMD = 12;
    busyCount = 0;
}

-(void)sendCMD0EWithPass:(NSString*)pass SN:(NSString*)sn Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Type:(int)type SubType:(NSString*)subType{
    CMD0E_AddSlaveDevice *cmd0e = [[CMD0E_AddSlaveDevice alloc]
                                   initWithPass:pass SN:sn Pid:pid Name:name Place:place Type:type Attach:subType
                                   ];
    [_helper sendCMD:cmd0e];
    [cmdDic setObject:cmd0e forKey:RECORD_CMD];
    lastCMD = 14;
    busyCount = 0;
}

-(void)sendCMD10WithDevid:(NSString*)devid{
    CMD10_DelDevice *cmd10 = [[CMD10_DelDevice alloc]initWithDevid:devid];
    [_helper sendCMD:cmd10];
    [cmdDic setObject:cmd10 forKey:RECORD_CMD];
    lastCMD = 16;
    busyCount = 0;
}

-(void)sendCMD58WithUsername:(NSString*)username OldPass:(NSString*)oldPass NewPass:(NSString*)newPass{
    CMD58_ChangePwd *cmd58 = [[CMD58_ChangePwd alloc]initWithUsername:username OldPass:oldPass NewPass:newPass];
    [_helper sendCMD:cmd58];
    [cmdDic setObject:cmd58 forKey:RECORD_CMD];
    lastCMD = 88;
    busyCount = 0;
}

-(void)sendCMD60WithUsername:(NSString*)username Email:(NSString*)email{
    CMD60_ForgetPwd *cmd60 =[[CMD60_ForgetPwd alloc]initWithUsername:username Email:email];
    [_helper sendCMD:cmd60];
    [cmdDic setObject:cmd60 forKey:RECORD_CMD];
    lastCMD = 96;
    busyCount = 0;
}

-(void)sendCMD62WithUsername:(NSString*)username Email:(NSString*)email Phone:(NSString*)phone{
    CMD62_ForgetPassWithVerifySetup1 *cmd62 = [[CMD62_ForgetPassWithVerifySetup1 alloc]initWithUsername:username Email:email Phone:phone];
    [_helper sendCMD:cmd62];
    [cmdDic setObject:cmd62 forKey:RECORD_CMD];
    lastCMD = 98;
    busyCount = 0;
}

-(void)sendCMD64WithUsername:(NSString*)username Email:(NSString*)email Pass:(NSString*)pass Uuid:(NSString*)uuid Code:(NSString*)code Phone:(NSString*)phone{
    CMD64_ForgetPassWithVerifySetup2 *cmd64 = [[CMD64_ForgetPassWithVerifySetup2 alloc]initWithUsername:username Email:email Phone:phone  Pass:pass Uuid:uuid Code:code] ;
    [_helper sendCMD:cmd64];
    [cmdDic setObject:cmd64 forKey:RECORD_CMD];
    lastCMD = 100;
    busyCount = 0;
}

-(void)sendCMD66WithUsername:(NSString*)username{
    CMD66_CheckUsername *cmd66 = [[CMD66_CheckUsername alloc]initWithUsername:username];
    [_helper sendCMD:cmd66];
    [cmdDic setObject:cmd66 forKey:RECORD_CMD];
    lastCMD = 102;
    busyCount = 0;
}

-(void)sendCMD68WithUsername:(NSString *)username Email:(NSString *)email Phone:(NSString*)phone{
    CMD68_RegisterWithVerifySetup1 *cmd68 = [[CMD68_RegisterWithVerifySetup1 alloc]initWithUsername:username Email:email Phone:phone];
    [_helper sendCMD:cmd68];
    [cmdDic setObject:cmd68 forKey:RECORD_CMD];
    lastCMD = 104;
    busyCount = 0;
}

-(void)sendCMD6AWithUsername:(NSString*)username Pass:(NSString*)pass Phone:(NSString*)phone Email:(NSString*)email UUID:(NSString*)uuid Code:(NSString*)code{
    CMD6A_RegisterWithVerifySetup2 *cmd6a =[[CMD6A_RegisterWithVerifySetup2 alloc]initWithUsername:username Pass:pass Phone:phone Email:email UUID:uuid Code:code];
    [_helper sendCMD:cmd6a];
    [cmdDic setObject:cmd6a forKey:RECORD_CMD];
    lastCMD = 106;
    busyCount = 0;
}

-(void)sendCMD71WithUUID:(NSString*)uuid Code:(NSString*)code{
    CMD71_VerifyCode *cmd71 = [[CMD71_VerifyCode alloc]initWithUUID:uuid Code:code];
    [_helper sendCMD:cmd71];
    [cmdDic setObject:cmd71 forKey:RECORD_CMD];
    lastCMD = 113;
    busyCount = 0;
}

#pragma mark -
#pragma mark receiveCMD

-(void)receiveCMD:(NSNotification*)notify{
    ServerCommand* cmd = [notify object];
    //错误指令
    if (cmd->CommandNo == [CMDFF_ServerException commandConst]) {
        CMDFF_ServerException *cmdff = (CMDFF_ServerException*)cmd;
        //如果错误码和上次发送的一致
        NSLog(@"----- ErrorCMDCode : %d",cmdff.CMDCode);
        if (cmdff.CMDCode == lastCMD) {
            //如果busy
            if (cmdff.code == 40) {
                busyCount ++;
                NSLog(@"------ busyCount : %d ------",busyCount);
                //超过3次发送busy错误提示
                if (busyCount > 3) {
                    //清0
                    busyCount = 0;
                    NSLog(@"------ Server is busy! ------");
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_BUSY object:[NSNumber numberWithInt:cmdff.CMDCode] userInfo:nil];
                    return;
                }
                //未超过3次则重新发送代码
                else{
                    [self performSelector:@selector(sendLastCmd) withObject:nil afterDelay:GAPTIME*((int)(busyCount/3)+1)];
                    NSLog(@"------ GAPTIME : %d ------",GAPTIME*((int)(busyCount/3)+1));
                }
            }
            //如果不再是40号指令，说明发送成功但已经出错，busyCount清0
            else{
                busyCount = 0;
            }
        }
    }
    //09号指令
    if (cmd->CommandNo == [CMD09_ServerControlResult commandConst]) {
        CMD09_ServerControlResult * cmd09 = (CMD09_ServerControlResult*)cmd;
        //先在此接收，保证是最新的状态
        Device * receiveDeviceStatus = cmd09.device;
        //需要延迟刷新
        if (needDelay == YES) {
            //判断是否立即更新设备的状态，还是延迟 n 秒后
            if (isManual == YES) {
                //手动发送08号指令返回的09号指令
                isManual = NO;
                if ([saveDeviceId isEqualToString:receiveDeviceStatus.id]) {
                    [reflashCmd09Timer invalidate];
                    reflashCmd09Timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(reflashCmd09:) userInfo:receiveDeviceStatus repeats:NO];
                }
            }
            //如果不是我们自己控制
            else{
                //如果定时器还没跑完，别人再次控制（也存在我们自己控制的2条09号指令一起到来，此时isManual = NO）
                if ([reflashCmd09Timer isValid]) {
                    [reflashCmd09Timer invalidate];
                    //更新成最新的设备状态，延迟设为2秒
                    reflashCmd09Timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reflashCmd09:) userInfo:receiveDeviceStatus repeats:NO];
                }
                //其他情况发送的更新设备状态的09号指令,立即执行更新
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:receiveDeviceStatus];
            }
        }
        //无需延迟，马上刷新
        else{
            //其他情况发送的更新设备状态的09号指令,立即执行更新
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:receiveDeviceStatus];
        }
    }
}
//重新发送CMD
-(void)sendLastCmd{
    ClientCommand *cmd = [cmdDic objectForKey:RECORD_CMD];
    [_helper sendCMD:cmd];
}

#pragma mark -
#pragma mark sendCMD8Thread

-(void)startSendCMD8Thread {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (_startSendCMD8) {
            int count = cmd8List.count;
            if (count == 0) {
                [cmd8Lock lock];
                [cmd8Lock wait];
                [cmd8Lock unlock];
                if (!_startSendCMD8) {
                    return;
                }
                continue;
            }
            [cmd8Lock lock];
            CMD08_ControlDevice* cmd8 = [cmd8List objectAtIndex:(count-1)];
            [cmd8List removeAllObjects];
            [cmd8Lock unlock];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_helper sendCMD:cmd8];
            });
            [NSThread sleepForTimeInterval:0.06];
        }
    });
}

-(void)stopSendCMDThread {
    [cmd8Lock lock];
    _startSendCMD8 = NO;
    [cmd8Lock signal];
    [cmd8Lock unlock];
}

-(void)addToCmd8List:(CMD08_ControlDevice*)cmd {
    [cmd8Lock lock];
    [cmd8List addObject:cmd];
    [cmd8Lock signal];
    [cmd8Lock unlock];
}

-(void)reflashCmd09:(NSTimer*)tiemr{
    NSLog(@"------ 延迟发送了 ------");
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:tiemr.userInfo];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
