//
//  LoginViewController.h
//  WiFiPlug
//
//  Created by apple on 13-11-9.
//  Copyright (c) 2013年 zcl. All rights reserved.
//

#import "SessionManger.h"
#import "GlobalMethod.h"
#import "MyGlobalData.h"
#import "ThreeDES.h"
#import "PublicCmdHelper.h"
#import "ImageUtils.h"
#import "MedicineBox-Swift.h"
#define ConnectTimeOut @"connectionTimeout"
#define TIMES 5
#define GAP 6
#define IsManual 2
#define ConnectHost @"connectHost"
#define ConnectPort @"connectPort"
//是否显示重连的对话框
static BOOL startSessionShowDialog = YES;
BOOL jump = NO;
BOOL closeSessionShowDialog = YES;

CMDHelper *helper;
////超时连接
//static const int CONNECT_TIMEOUT = 10;
int count ;
@implementation SessionManger {
    //心跳定时器
    NSTimer *timer;
    //连接服务器计时器
    NSTimer * connectionTimer;
    NSTimer * reflashCmd09Timer;//当收到09号指令时，不立刻刷新，而是过X秒后再刷新
    NSTimer * reflashCmd8eTimer;//当收到8e号指令时，不立刻刷新，而是过X秒后再刷新
    NSString * saveDeviceOrGroupId;//用来保存前一个cmd09 指令操作的设备Id号
    //超时重连警告筐
    UIAlertView* reconnectAlertview;
    //连接超时警告筐
    UIAlertView * connectTimeOut;
    
    
    NSMutableArray * timerList;//用于接收所有设备的定时任务
    //    BOOL isManualSocket;//是否手动断开socket
    NSTimer * reconnectTimer;//连续发送多次连接服务器定时器
    int reconnectTimes;//连接的次数
    NSUserDefaults * userDefault;
    PublicCmdHelper * publicCmdHelper;
    ClientCommand *cmd08Temp;//缓存
    NSTimer *timerSend08;
    
}
@synthesize username=_username,password=_password,autoLogin=_autoLogin,isConnected=_isConnected,isLogin=_isLogin,stayOnline=_stayOnline,delegate,backDown=_backDown,userInfo = _userInfo,host = _host,port,reg_account = _reg_account,reg_email=_reg_email,reg_password=_reg_password,reg_phone=_reg_phone,find_account=_find_account,find_email=_find_email,reg_code = _reg_code, reg_uuid = _reg_uuid;
@synthesize isBackground=_isBackground,mode = _mode,isConfiguration;
static SessionManger* instance;

+(SessionManger*)shareSessionManger {
    if (nil == instance) {
        instance = [[SessionManger alloc]init];
    }
    return instance;
}


//域名转ip
+ (NSString *)queryIpWithDomain:(NSString *)domain
{
    struct hostent *hs;
    struct sockaddr_in server;
    if ((hs = gethostbyname([domain UTF8String])) != NULL)
    {
        server.sin_addr = *((struct in_addr*)hs->h_addr_list[0]);
        return [NSString stringWithUTF8String:inet_ntoa(server.sin_addr)];
    }
    return nil;
}


-(id)init {
    self = [super init];
    if (self) {
        appid=1;
        _autoLogin = YES;
        _isConnected = NO;
        _isLogin  = NO;
        _stayOnline = NO;
        _username = USER;
        _password = PASS;
        _userInfo = nil;
        _backDown = NO;
        count = 0;
        _host = nil;
        port = 0;
        isConfiguration = NO;
        userDefault = [NSUserDefaults standardUserDefaults];
        timerList = [[NSMutableArray alloc] init];
        _isBackground = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connect:) name:kSocketConnect object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close:) name:kSocketClose object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCMD:) name:kReceiveCMD object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(becomeActivity:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackGround:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        helper = [CMDHelper shareInstance];
        helper.delegate = self;
        publicCmdHelper = [PublicCmdHelper sharePublicCmdHelperInstance];
        startSessionShowDialog = YES;
        closeSessionShowDialog = YES;
        //        _drugTimes = [NSArray array];
        _pationImages = [[NSMutableDictionary alloc] init];
        _pationInfos = [[NSMutableDictionary alloc] init];
        reconnectAlertview = [[UIAlertView alloc] initWithTitle:@"提示" message:NSLocalizedString(@"服务器连接失败，请检查网络", nil)  delegate:self cancelButtonTitle:NSLocalizedString(@"退出", nil)  otherButtonTitles:NSLocalizedString(@"重连", nil) , nil];
        
        //NSString *lan=[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"error_list" ofType:@"plist"];
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"error_list" ofType:@"plist"inDirectory:nil forLocalization:lan];
        if (plistPath==nil) {
            plistPath=[[NSBundle mainBundle] pathForResource:@"error_list" ofType:@"plist"inDirectory:nil forLocalization:@"en"];
        }
        errorDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return self;
}
#pragma mark- NSNotification Center
-(void)connect:(NSNotification*)notify {
    NSNumber* tag = notify.object;
    NSLog(@"connect socket TAG:%d",tag.intValue);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self cancelReconnectTimer];
    [helper sendCMD:[[CMD00_ConnectRequet alloc] init]];
    
    
}

-(void)close:(NSNotification*)notify {
    NSNumber* tag = notify.object;
    NSLog(@"close socket TAG:%d",tag.intValue);
    [timer invalidate];
    //_host = nil;
    _isConnected = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (_isLogin == NO) {
        _stayOnline =NO;
    }
    if (tag.intValue != IsManual) {
        if (_stayOnline) {
            [GlobalMethod closePressDialog];
            [self cancelReconnectTimer];
            if (reconnectAlertview.visible == NO) {
                [reconnectAlertview show];
            }
        }
    }
    jump = NO;
}
-(void)removeAlertView{
    [reconnectAlertview dismissWithClickedButtonIndex:0 animated:NO];
    
    [connectTimeOut dismissWithClickedButtonIndex:0 animated:NO];
    
}
-(void)becomeActivity:(NSNotification*)obj{
    if (_isLogin == YES) {
        if ([helper isConnected]) {
            return;
        }
        [self removeAlertView];
        [GlobalMethod showProgressDialog:@"加载中..."];
        [helper connect];
        [self cancelReconnectTimer];
        reconnectTimes = 1;
        reconnectTimer = [NSTimer scheduledTimerWithTimeInterval:GAP target:self selector:@selector(reconnect) userInfo:nil repeats:YES];
        [connectionTimer invalidate];
        connectionTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(connectTimeOut) userInfo:nil repeats:NO];
    }
}
-(void)enterBackGround:(NSNotification*)obj{
    [self removeAlertView];
}
-(void)receiveCMD:(NSNotification*)obj {
    
    ServerCommand* cmd = [obj object];
    
    if (cmd->CommandNo == [CMDFF_ServerException commandConst]) {
        [GlobalMethod closePressDialog];
        CMDFF_ServerException *cmdff = (CMDFF_ServerException*)cmd;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Combination_FF" object:nil];
        NSLog(@"%d",cmdff.code);
        NSMutableDictionary * info;
        if (cmdff.CMDCode == 2) {
            [userDefault setObject:nil forKey:ConnectHost];
            [userDefault setInteger:0 forKey:ConnectPort];
            [userDefault synchronize];
        }
        NSString *value=[NSString stringWithFormat:@"%@",[self->errorDic objectForKey:[NSString stringWithFormat:@"%d",cmdff.code]]];
        info = [[NSMutableDictionary alloc]init];//alloc]initWithObjectsAndKeys:value,cmdff.CMDCode,@"info",@"", nil];
        [info setObject:value forKey:@"info"];
         [info setObject:[NSString stringWithFormat:@"%d",cmdff.code] forKey:@"code"];
        [info setObject:[NSString stringWithFormat:@"%d",cmdff.CMDCode] forKey:@"CMDCode"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REC_FF object:info];
        return;
    }
    if (cmd->CommandNo == [CMDFB_ServerIdle commandConst]) {
        [timer invalidate];
        [connectionTimer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:90 target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
        CMDFC_IdleSucc * cmdfc = [[CMDFC_IdleSucc alloc] init];
        [helper sendCMD:cmdfc];
        return;
    }
    if (cmd->CommandNo == [CMD01_ServerLoginPermit commandConst]) {
        
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"DEVICE_TOKEN"];
        
        CMD73_SetParameter * cmd73 =[[CMD73_SetParameter alloc] initWithAPPID:self->appid Locale:@"cn" Platform:@"i" DeviceToke:deviceToken EnablePush:YES APPVer:APPVersion];
        [helper sendCMD:cmd73];
        [timer invalidate];
        [connectionTimer invalidate];
        
        return;
    }
    if (cmd->CommandNo == [CMD74_ServerReturnParameter commandConst]) {
        _cmd74 = (CMD74_ServerReturnParameter*)cmd;
        _url_img=[NSString stringWithFormat:@"%@",_cmd74.imageServer];
        //版本判断
        if(_cmd74.appLatestVer!=nil&&_cmd74.appLatestVer.length>0&&![self checkVersion:_cmd74.appLatestVer]){
            //判断连接是否存在
            if (_cmd74.appLatestURL&&_cmd74.appLatestURL.length>0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_UPDATE_APP object:nil];
                return;
            }
        }
        [timer invalidate];
        [connectionTimer invalidate];
        if ([_mode isEqual:@"login"]) {
            //用[NSDate date]可以获取系统当前时间
            NSDate* currentDate = [NSDate date];
            //获取时区设置
            NSTimeZone* zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:currentDate];
            NSInteger timeZone = interval/60/60;
            NSLog(@"时区:%ld",(long)timeZone);
            CMD02_Login* cmd02 =[[CMD02_Login alloc] initWithUser:_username Pass:_password Offset:timeZone appid:self->appid];
            [helper sendCMD:cmd02];
            
        }
        [self notifyRecCMD:cmd];
        return;
    }
    
    if (cmd->CommandNo == [CMD03_ServerLoginRespond commandConst]) {
        _isLogin  = YES;
        CMD03_ServerLoginRespond *cmd03 = (CMD03_ServerLoginRespond*)cmd;
        _userInfo = cmd03.info;
        if (isConfiguration == NO) {
            CMDA1_GetAllMedicineBox *cmda = [[CMDA1_GetAllMedicineBox alloc] init];
            [self sendCmd:cmda];
        }
        [self notifyRecCMD:cmd];
        return;
    }
    
    if (cmd->CommandNo == [CMD0D_ServerAddMasterDeviceResult commandConst]) {
        CMDA1_GetAllMedicineBox *cmda = [[CMDA1_GetAllMedicineBox alloc] init];
        [self  sendCmd:cmda];
        [self notifyRecCMD:cmd];
        return;
    }

    if (cmd->CommandNo == [CMD15_ServerModifyUserResult commandConst]) {
        
        CMD15_ServerModifyUserResult *cmd15 = (CMD15_ServerModifyUserResult*)cmd;
        _userInfo = cmd15.info;
         [self notifyRecCMD:cmd];
        return;
    }
    if (cmd->CommandNo == [CMDA0_ServerEditMedicineResult commandConst]) {
        CMDA0_ServerEditMedicineResult *cmda0 = (CMDA0_ServerEditMedicineResult*)cmd;
        MedicineInfo *info = cmda0.info;
        for (int i = 0; i < _medicineBoxs.count; i++) {
            MedicineBox *mBox =[_medicineBoxs objectAtIndex:i];
            if ([info.macId containsString:mBox.macId]) {
                for (int j = 0; j < mBox.list.count; j++) {
                    if ([[mBox.list objectAtIndex:j].rfid containsString:info.rfid]) {
                        
                        NSMutableArray *array = [NSMutableArray arrayWithArray:mBox.list];
                        [array replaceObjectAtIndex:j withObject:info];
                        mBox.list = array;
                        [_medicineBoxs replaceObjectAtIndex:i withObject:mBox];
                        
                       [self notifyRecCMD:cmd];
                        return;
                    }
                    
                }
                NSMutableArray *array = [NSMutableArray arrayWithArray:mBox.list];
                [array addObject:info];
                mBox.list = array;
                [_medicineBoxs replaceObjectAtIndex:i withObject:mBox];
                [self notifyRecCMD:cmd];
                return;
                
            }
        }
        
        [self notifyRecCMD:cmd];
    }
 
    
    if(cmd->CommandNo == [CMDA2_ServerGetAllMedicineBox commandConst]){
        CMDA2_ServerGetAllMedicineBox *cmdA2 = (CMDA2_ServerGetAllMedicineBox*)cmd;
        _medicineBoxs = [[NSMutableArray alloc] initWithArray: cmdA2.list];
            for (MedicineBox* d in cmdA2.list) {
                UIImage *img =[UtilSw readImageFromSandBoxByDeviceId:d.macId];
                if (img!=nil) {
                    [_pationImages setObject:img forKey:d.macId];
                }
                if (_url_img != nil && _url_img.length > 0) {
                //下载图片
                NSDictionary *defaultAsDic = [userDefault dictionaryRepresentation];
                //得到userDefault中所有的Key
                NSArray *keyArr = [defaultAsDic allKeys];
                //是否是userdefault里未添加的device
                BOOL isNewDevice = YES;
                for (NSString *key in keyArr) {
                    if ([key isEqualToString:d.macId]) {
                        NSNumber *tempImgVer = [userDefault objectForKey:d.macId];
                        isNewDevice = NO;
                        NSLog(@"本地版本号为：%d；设备版本号为：%d",[tempImgVer intValue],d.iconVer,nil);
                        //如果版本不同
                        if ([tempImgVer intValue] != d.iconVer) {
                            //下载图片
                            NSURL *url = [NSURL URLWithString: URL_GET_DPHOTO(_url_img,[ThreeDES  encryptWithDefautKey:TOKEN_DEVICE(_userInfo.name,self.password,d.macId )])];
                            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                            [request setRequestMethod:@"GET"];
                            [request setDelegate:self];
                            [request startAsynchronous];
                            //设为已添加
                        }
                        break;
                    }
                }
                
                if (isNewDevice) {
                    [userDefault setObject:[NSNumber numberWithInt:0] forKey:d.macId];
                    //下载图片
                    NSURL *url = [NSURL URLWithString: URL_GET_DPHOTO(_url_img,[ThreeDES  encryptWithDefautKey:TOKEN_DEVICE(_userInfo.name,self.password,d.macId)])];
                    NSLog(@"下载图片地址：%@",URL_GET_DPHOTO(_url_img,[ThreeDES  encryptWithDefautKey:TOKEN_DEVICE(_userInfo.name,self.password,d.macId )]) );
                    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                    [request setRequestMethod:@"GET"];
                    [request setDelegate:self];
                    [request startAsynchronous];
                }
                
            }
            
        }
       
        [_pationInfos removeAllObjects];
        [self sendCmd:[[CMDAF_GetAllPationInfo alloc] init]];
        [self notifyRecCMD:cmd];
        
        
        return;
    }
    if (cmd->CommandNo == [CMDBB_ServerFindNewMedicine commandConst]) {
        CMDBB_ServerFindNewMedicine *cmdbb = (CMDBB_ServerFindNewMedicine*)cmd;
        for (int i=0; i<_medicineBoxs.count; i++) {
            if ([[_medicineBoxs objectAtIndex:i].macId isEqualToString:cmdbb.medicineBox.macId]) {
                [_medicineBoxs replaceObjectAtIndex:i withObject:cmdbb.medicineBox];
                break;
            }
        }
        
        [self notifyRecCMD:cmd];
        return;
       
    }
    if (cmd->CommandNo == [CMDAE_ServerSetPationInfoResult commandConst]) {
        CMDAE_ServerSetPationInfoResult *cmdae = (CMDAE_ServerSetPationInfoResult*)cmd;

        [_pationInfos setObject:cmdae.pationInfo forKey:cmdae.pationInfo.macId];
        [self notifyRecCMD:cmd];
      
        return;
        //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REC_FF object:nil];
    }
    if(cmd->CommandNo == [CMDB0_ServerReturnAllPationInfo commandConst]){
        CMDB0_ServerReturnAllPationInfo *cmdaa = (CMDB0_ServerReturnAllPationInfo*)cmd;
        //        _pationInfos = ;
        _pationInfos = [[NSMutableDictionary alloc] init];
        for (PationInfo *info in cmdaa.pationInfos) {
            [_pationInfos setObject:info forKey:info.macId];
        }
         [GlobalMethod closePressDialog];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_GETALLDEVICE object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ALL_PATIONINFOS object:nil];
        [self notifyRecCMD:cmd];
        return;
    }
    
    if(cmd->CommandNo == [CMD05_ServerRespondAllDeviceList commandConst]) {
        _stayOnline = YES;
        CMD05_ServerRespondAllDeviceList* cmd05 = (CMD05_ServerRespondAllDeviceList*)cmd;
//        NSMutableArray* array = [[NSMutableArray alloc] init];
        
        _onlineMacString = [[NSMutableString alloc] init];
        for (Device* d in cmd05.deviceList) {
            if (d.online && d.id.length > 0) {
                [_onlineMacString appendString:d.id];
            }
        }
         [self notifyRecCMD:cmd];
//        [MyGlobalData setDeviceList:array];
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_GETALLDEVICE object:cmd05];
        //        }
        
        return;
    }
    if (cmd->CommandNo == [CMD09_ServerControlResult commandConst]) {
        CMD09_ServerControlResult * cmd09 = (CMD09_ServerControlResult*)cmd;
        CommonDevice * receiveDeviceStatus =(CommonDevice*) cmd09.device;
        if (_onlineMacString == nil) {
            _onlineMacString = [[NSMutableString alloc] init];
        }
        
        if (receiveDeviceStatus.online) {
            if (![_onlineMacString containsString:receiveDeviceStatus.id]) {
                [_onlineMacString appendString:receiveDeviceStatus.id];
            }
        }else{
            _onlineMacString = [NSMutableString stringWithString:[_onlineMacString stringByReplacingOccurrencesOfString:receiveDeviceStatus.id withString:@""]];
        }
        NSLog(@"online:%@",_onlineMacString);
        // 收到09号指令后，将相应的设备列表更新成最新的状态
//        NSMutableArray * deviceList = [MyGlobalData getDeviceList];
//        int count = (int)deviceList.count;
//        for (int i = 0 ; i < count; i++) {
//            CommonDevice * tempDeviceStatus = [deviceList objectAtIndex:i];
//            if ([tempDeviceStatus.id isEqualToString:receiveDeviceStatus.id]) {
//                [deviceList replaceObjectAtIndex:i withObject:receiveDeviceStatus];
//                break;
//            }
//        }
//        [MyGlobalData setDeviceList:deviceList];
        [self notifyRecCMD:cmd];
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:cmd09];
        return;

        
    }
    if (cmd->CommandNo == [CMD11_ServerDelDeviceResult commandConst]) {
        CMD11_ServerDelDeviceResult * cmd11 = (CMD11_ServerDelDeviceResult *)cmd;
        if (cmd11.result == YES) {
            CommonDevice *d = cmd11.device;
            NSMutableArray *list = [MyGlobalData getDeviceList];
            for (int i = 0; i < [list count]; i++) {
                CommonDevice *dev = [list objectAtIndex:i];
                if ([dev.id isEqualToString:d.id]) {
                    [[MyGlobalData getDeviceList] removeObject:dev];
                }
            }
        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:cmd11];
        [self notifyRecCMD:cmd];
        return;
    }else
    if (cmd->CommandNo == [CMDC1_ServerMedicineBoxDeleteResult commandConst]) {
        CMDC1_ServerMedicineBoxDeleteResult * cmdC1 = (CMDC1_ServerMedicineBoxDeleteResult *)cmd;
        
//            CommonDevice *d = cmdC1.device;
            NSMutableArray *list = [MyGlobalData getDeviceList];
        int leng = (int)list.count;
            for (int i = 0; i < leng; i++) {
                CommonDevice *dev = [list objectAtIndex:i];
                if ([dev.id isEqualToString:cmdC1.macAddr]) {
                    [[MyGlobalData getDeviceList] removeObject:dev];
                }
            }
        
        for (int i = 0; i < _medicineBoxs.count; i++) {
            
            if ([_medicineBoxs[i].macId containsString:cmdC1.macAddr]) {
                [_medicineBoxs removeObjectAtIndex:i];
            }
            
        }
        
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:cmd11];
        [self notifyRecCMD:cmd];
        return;
    }
    if (cmd->CommandNo == [CMD13_ServerModifyDeviceResult commandConst]) {
        CMD13_ServerModifyDeviceResult * cmd13 = (CMD13_ServerModifyDeviceResult *)cmd;
        if (cmd13.result == YES) {
            CommonDevice *d = cmd13.device;
            NSMutableArray *list = [MyGlobalData getDeviceList];
            for (int i = 0; i < [list count]; i++) {
                CommonDevice *dev = [list objectAtIndex:i];
                if ([dev.id isEqualToString:d.id]) {
                    [[MyGlobalData getDeviceList] replaceObjectAtIndex:[list indexOfObject:dev] withObject:d];
                }
            }
        }
        [self notifyRecCMD:cmd];
        return;
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:cmd13];
    }
    if (cmd->CommandNo == [CMD25_ServerQueryTimerResult commandConst]) {
        CMD25_ServerQueryTimerResult * cmd25 = (CMD25_ServerQueryTimerResult *)cmd;
        
        
        //        int count = cmd25.timerList.count;
        //把属于这个设备之前保存的定时消息清理
        NSString * deviceId = cmd25.devid;
        [[MyGlobalData getTimerDictronary] removeObjectForKey:deviceId];
        NSArray  *ts = cmd25.timerList;
        if (ts == nil) {
            ts = [[NSArray alloc] init];
        }
        [[MyGlobalData getTimerDictronary] setObject:ts forKey:deviceId];
        for (CommonDevice *dev in  [MyGlobalData getDeviceList]) {
            if (![[[MyGlobalData getTimerDictronary] allKeys ] containsObject:dev.id]) {
                [self sendCmd:[[CMD24_QueryTimer alloc] initWithDevid:dev.id]];
                return;
            }
        }
        [self notifyRecCMD:cmd];
        return;
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RECEIVE_ALL_TIMER object:nil];
    }
    
    
    
    if (cmd->CommandNo == [CMD11_ServerDelDeviceResult commandConst]) {
        [GlobalMethod closePressDialog];
        CMD11_ServerDelDeviceResult *cmd11 = (CMD11_ServerDelDeviceResult*)cmd;
        NSMutableArray<CommonDevice*> *array = [MyGlobalData getDeviceList];
        
        
        for (int i = 0; i<[array count]; i++) {
            if ([cmd11.device.id isEqualToString:[array objectAtIndex:i].id]) {
                [[MyGlobalData getDeviceList] removeObjectAtIndex:i];
                [[MyGlobalData getTimerDictronary] removeObjectForKey:cmd11.device.id];
                break;
            }
        }
        [self notifyRecCMD:cmd11];
        return;
    }
     [self notifyRecCMD:cmd];
    
}


-(void)notifyRecCMD:(ServerCommand*)cmd{
    //[dic setObject:cmd.commandConst forKey:@"CMDCode"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REC_CMD object:cmd];
}

#pragma mark- TimerOut Method
//超时时显示的警告对话筐
-(void)timeout:(id)sender{
    _isConnected = NO;
    [self cancelReconnectTimer];
    if (self.stayOnline == YES) {
        [reconnectAlertview show];
    }
}
//没有在限定的时间内收到回复数据，则视为网络出现异常
-(void)connectTimeOut {
    [GlobalMethod closePressDialog];
    [connectionTimer invalidate];
    [self cancelReconnectTimer];
    connectTimeOut = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"连接超时，请重试", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"否", nil) otherButtonTitles:NSLocalizedString(@"是", nil), nil];
    [connectTimeOut show];
}
-(void)reconnect{
    if (reconnectTimes<TIMES) {
        [helper connect];
        reconnectTimes++;
    }else{
        [GlobalMethod closePressDialog];
        [self cancelReconnectTimer];
        connectTimeOut = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"连接超时，请重试", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"否", nil) otherButtonTitles:NSLocalizedString(@"是", nil), nil];
        [connectTimeOut show];
    }
}
-(void) cancelReconnectTimer{
    if (reconnectTimer != nil ) {
        [reconnectTimer invalidate];
        //        reconnectTimer = nil;
    }
}
-(void)reflashCmd09{
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_DEVICE_STATES object:nil];
    NSLog(@"relash cmd09");
}

#pragma mark- UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == connectTimeOut || alertView == reconnectAlertview) {
        if (1 == buttonIndex) {
            [GlobalMethod showProgressDialog:NSLocalizedString(@"加载中...", nil)];
            [self startSession];
            //连接服务器开始计时
            [connectionTimer invalidate];
            connectionTimer = [NSTimer scheduledTimerWithTimeInterval:TIME_OUT target:self selector:@selector(connectTimeOut) userInfo:nil repeats:NO];
        }else if (buttonIndex == 0){
            [connectionTimer invalidate];
            [self closeSession:YES];
        }
    }
}

-(MedicineBox *)getCurrentDevice{
    if (_currentDid!=nil) {
        for (MedicineBox *box in _medicineBoxs) {
            if ([box.macId isEqualToString:_currentDid]) {
                return  box;
            }
        }
    }
    return nil;
}
#pragma mark 网络会话相关
-(void)startSession {
    if (NO == _isConnected) {
        [self closeSession:YES];
        if ([_mode isEqualToString:@"login"]) {
            _host = [userDefault valueForKey:ConnectHost];
            port =((NSNumber*) [userDefault valueForKey:ConnectPort]).intValue;
        }
        
        
        if (_host == nil || [_host isEqual:@""]) {
            
            NSString *hostIP = [SessionManger queryIpWithDomain:HOSTNAME];
            if(!hostIP || hostIP == nil || [hostIP isEqual: @""]){
                [GlobalMethod toast:@"无网络连接"];
                [GlobalMethod closePressDialog];
                return;
            }
 
//#ifndef HOST
//#define HOST hostIP
//#endif
            
            _host = hostIP;
            
            [CMDHelper setupConnectionWithIp:_host Port:PORT withTimeOut:10];
            [self cancelReconnectTimer];
            reconnectTimes = 1;
            reconnectTimer = [NSTimer scheduledTimerWithTimeInterval:GAP target:self selector:@selector(reconnect) userInfo:nil repeats:YES];
        }else {
            [CMDHelper setupConnectionWithIp:_host Port:(int)port withTimeOut:10];
            [self cancelReconnectTimer];
            reconnectTimes = 1;
            reconnectTimer = [NSTimer scheduledTimerWithTimeInterval:GAP target:self selector:@selector(reconnect) userInfo:nil repeats:YES];
            //            _isLogin = YES;
        }
    }
}

-(void)closeSession:(BOOL)sendAction {
    
    //当手动关闭连接时，不提示网络断开
    closeSessionShowDialog = sendAction;
    if (sendAction == YES) {
        [helper close];
        //        _isLogin = NO;
        _isConnected = NO;
        _stayOnline = NO;
        [self cancelAllTimer];
    }else {
        
    }
    
}
-(void)closeSocket{
    [helper closeWithTag:IsManual];
    _isConnected = NO;
    _stayOnline = NO;
    [self cancelAllTimer];
    
}
-(void)cancelAllTimer {
    if (timer != nil) {
        [timer invalidate];
        timer = nil;;
    }
    if (connectionTimer != nil) {
        [connectionTimer invalidate];
        timer = nil;
    }
    if (reflashCmd09Timer != nil) {
        [reflashCmd09Timer invalidate];
    }
    if (reflashCmd8eTimer != nil) {
        [reflashCmd8eTimer invalidate];
    }
}
-(void)cancel09and8eTimer{
    if (reflashCmd09Timer != nil) {
        [reflashCmd09Timer invalidate];
    }
    if (reflashCmd8eTimer != nil) {
        [reflashCmd8eTimer invalidate];
    }
}
-(BOOL)isConnected {
    _isConnected = [helper isConnected];
    return _isConnected;
}

-(void)sendCmd:(ClientCommand * )cmd{
    if ([self isConnected] == NO) {
        if (reconnectAlertview.visible == NO) {
            [reconnectAlertview show];
        }
        return;
    }
    if (cmd->CommandNo == [CMD10_DelDevice commandConst]) {
        CMD10_DelDevice * cmd10 = (CMD10_DelDevice*)cmd;
        [publicCmdHelper sendCMD10WithDevid:cmd10.devid];
    }else if(cmd->CommandNo == [CMD08_ControlDevice commandConst]){//延迟一秒发生
        if (timerSend08!=nil && [timerSend08 isValid]) {
            cmd08Temp = cmd;
        }else{
            [helper sendCMD:cmd];
            [self startTimerSend08];
        }
        
    }else{
        [helper sendCMD:cmd];
    }
    
}

-(void)startTimerSend08{
    timerSend08 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendCmd08) userInfo:nil repeats:NO];
}

-(void)sendCmd08{
    if (cmd08Temp) {
        [helper sendCMD:cmd08Temp];
        cmd08Temp = nil;
    }
    timerSend08 = nil;
    
}
-(void)cancelTimerSend08{
    if (timerSend08) {
        [timerSend08 invalidate];
        timerSend08 = nil;
    }
    
}
#pragma mark--CMDHelperDelegate
-(CommonDevice *)CMDHelper:(CMDHelper *)helper parseDeviceWithSn:(NSString *)sn Type:(int)type State:(NSString *)state{
    if (type == MedicineBoxDeviceType) {
        return [[MedicineBoxDevice alloc] init];
    }else{
        return nil;
    }
}
//返回yes则当前版本是最新的版本
-(BOOL)checkVersion:(NSString*)lastVersion{
    NSString *localversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"最新的版本号：%@，当前的版本号：%@",lastVersion,localversion);
    return [localversion isEqualToString:lastVersion];
}


#pragma mark - ASIHTTPDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic = [request responseHeaders];
    //取得服务器发来的对应的MAC
    NSString *did = [dic objectForKey:@"deviceSn"];
    NSString *user=[dic objectForKey:@"username"];
    
    BOOL isUserPic=NO;
    if (did&&did.length > 0) {
        NSLog(@"did is  %@,user is %@",did,user);
    }else if(user&&user.length>0){
        NSLog(@"user is  %@,did is %@",user,did);
        isUserPic=YES;
        did=user;
    }else{
        NSString *picKey;
        //        if ( [ThLoginUtil shareInstance].thirdUser ) {
        //            if ([ [ThLoginUtil shareInstance].thirdUser.loginType isEqualToString:QQ_LOGIN_TYPE]) {
        //                picKey=[ [ThLoginUtil shareInstance].thirdUser openId_QQ];
        //            }
        //        }
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        
        UIImage *image = [UIImage imageWithData:responseData];
        if (did == nil) {
            return;
        }
        [_pationImages setObject:image forKey:did];
        if (image != nil && picKey) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:picKey];
            [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPhoto" object:nil];
            
        }
        
        return;
    }
    
    //取得服务器发来的版本号
    NSString *iconVer = [dic objectForKey:@"iconVer"];
    //得到最后的版本号
    NSNumber *lastVerNum = [userDefault objectForKey:did];
    if (!lastVerNum) {
        NSLog([NSString stringWithFormat:@"得到最后的版本号为空！！",nil],nil);
        //        return;
    }
    int lastVerNumIntValue = [lastVerNum intValue];
    if (iconVer != nil) {
        //版本号变为现在的版本号
        lastVerNumIntValue = [iconVer intValue];
    }else{
        //版本号+1
        lastVerNumIntValue ++;
    }
    
    //重新保存
    [userDefault setObject:[NSNumber numberWithInt:lastVerNumIntValue] forKey:did];
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    
    UIImage *image = [UIImage imageWithData:responseData];
    [_pationImages setObject:image forKey:did];
    if (image != nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:did];
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        if (isUserPic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPhoto" object:nil];
        }
    }
    
    //    NSLog(@"收到图片并保存图片到Document中!");
    if (request.responseStatusCode == 200) {
        NSLog(@"下载成功！");
    }else{
        NSLog(@"下载失败！");
    }
}
@end
