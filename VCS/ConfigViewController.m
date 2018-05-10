//
//  ConfigViewController.m
//  MedicineBox
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 jxm. All rights reserved.
//

#import "ConfigViewController.h"
// 一键配置
#define CONFIG_TIME_OUT 60
//#define CHECK_WIFI_TIME 1
#import "ControlTcpSocket.h"
#import "Util.h"
#import "ConfigWifi.h"
#import "CMDFactory.h"
#define WIFINAME @"iRemote"

#import "MedicineBox-Swift.h"
// wifi配置
#import "Bolloon.h"
#import "GlobalMethod.h"
#import "SessionManger.h"
#import "Reachability.h"
//#import "ServerResult.h"
#import "MyGlobalData.h"
#import <Protocol/CMDHelper.h>
#import <Protocol/CMD03_ServerLoginRespond.h>
#import <Protocol/CMD04_GetAllDeviceList.h>
#import <Protocol/CMD0C_AddMasterDevice.h>
#import <Protocol/CMD0D_ServerAddMasterDeviceResult.h>
#import <Protocol/CMD16_QueryUserInfo.h>
#import <Protocol/CMD17_ServerQueryUserResult.h>
//#import "UserDevice.h"

#define TIMES 3
#define PASSWORD_KEY @"wifiPassword"
#define WIFINAME_KEY @"wifiName"

#define TEMP_TIME_OUT 10
#define CHECK_WIFI_TIME 0.5
#define ADD_DEVICE_TIME_OUT 30

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ConfigViewController (){
    //一键配置
    SmartConfig1 *smartConfig;
    CMDFactory *cmdFactory;
//    ConfigWifi *configWifi;
    
    NSTimer * checkWifiCanUse;        //检查网络是否可用
    int checkWifiCount;               //检测网络可用次数
    NSTimer *timerOut;                //一键配置接受不到数据没有代理成功或失败时的超时处理
    BOOL isShowPass;
    BOOL isConfig;
    BOOL isSmartConfig;
    BOOL isConfigCancel;
    
    
    //共同
    NSMutableArray * deviceTableArray;//设备列表
    NSUserDefaults * userDefaults;
    NSTimer * sendCmdTimer;
    UIView *backView;
    UIView *coverView;
    int angle;
    BOOL isStop;
    NSTimer *lightTimer;
    SessionManger * sm;
    CMDHelper * helper;
    BOOL matchSuccess;                //判断是否匹配成功
    NSTimer *sendPacketTimer;         //匹配设备计时器
    NSString *macAddress;             //匹配到的Mac地址
    NSString * wifi_ssid;             //Wi-Fi名称
    id info;                          //Wi-Fi信息
    Reachability * reach;             //检测网络是否连通
    UIAlertView * networkAlertView;   //判断网络是否可用
    UIAlertView * alert;
    UIAlertView * wifiAlert;
    NSTimer * addDeviceTimer;         //添加设备等待时间
    NSTimer * checkWifiDisappearTimer;//检查设备热点是否消失
    BOOL isRememberMe;
    
    int sendPacketTimes;              //发送包的次数
    
    //WIFI配置
    NSMutableData *_datas;            //接收信息采集回调的信息
    
    
}

@end

@implementation ConfigViewController
- (void)back{
    sm.isLogin = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配置设备";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    CGRect leftBarItemRect = CGRectMake(0, 20, 44, 44);
    UIButton *leftBarItem = [[UIButton alloc] initWithFrame:leftBarItemRect];
    leftBarItem.backgroundColor = [UIColor clearColor];
    [leftBarItem setTitle:@"" forState:(UIControlStateNormal)];
    [leftBarItem setImage:[UIImage imageNamed:@"返回ICON"] forState:(UIControlStateNormal)];
    [leftBarItem setImage:[UIImage imageNamed:@"返回ICON按下"] forState:(UIControlStateHighlighted)];
    [leftBarItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    leftBarItem.tag = 999;
    //[self.view.window addSubview:leftBarItem];
    [[UIApplication sharedApplication].keyWindow addSubview:leftBarItem];
    
    
    for (UIView *subV in self.view.subviews) {
        if (subV.tag == 121) {
            self.mMain = subV;
            break;
        }
    }
    
    self.tf_routerPwd.delegate = self;
    self.tf_ssid.delegate = self;
    sm = [SessionManger shareSessionManger];
    sm.isLogin = NO;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    //是空调的话
//    configWifi = [[ConfigWifi alloc]init];
    cmdFactory  = [CMDFactory getInstance];
    smartConfig  = [SmartConfig1 getInstance];
    smartConfig.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = false;
    self.title = @"配置设备";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //    NSString * wifiname =[self.tf_routerPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    if (wifiname.length <= 0) {
    //        self.btn_showPwd.hidden = true;
    //    }else{
    //        self.btn_showPwd.hidden = false;
    //    }
    
    sm.isConfiguration = YES;
    
    info = [GlobalMethod getNetworkInfo];
    wifi_ssid = [info objectForKey:@"SSID"];
    if (wifi_ssid != nil){
        self.tf_ssid.text = wifi_ssid;
        //    if (self.tf_ssid.text){
        self.tf_routerPwd.text = [userDefaults valueForKey:wifi_ssid];
        //    }
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCMD:) name:kReceiveCMD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAllDevice:) name:@"getAllDevice" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFF:) name:@"Receive_FF" object:nil];
    
    //当与设备匹配收到结果，得到通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataFromServer:) name:InitSetting object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterBackGround:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configSuccess:) name:CONFIG_STATUS object:nil];
    
    //启用检测
    [reach startNotifier];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    if([[UIScreen mainScreen] bounds].size.height == 480){
        CGRect frame = self.fastLight.frame;
        frame.origin.y = SCREEN_HEIGHT / 2;
        
        self.fastLight.transform = CGAffineTransformMakeTranslation(0, -150);
        self.fastLight.hidden = NO;
        
    }
    
    backView = [[UIView alloc] init];
    backView.frame = self.mMain.frame;
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self.mMain addSubview:backView];
    [(AppDelegate *)([UIApplication sharedApplication].delegate) showMask];
    
    for(UIView *v in [UIApplication sharedApplication].keyWindow.subviews){
        if (v.tag == 999){
            [[UIApplication sharedApplication].keyWindow bringSubviewToFront:v];
        }
    }
    
    [self firstStep];
    
    angle = 0;
    
    CGRect frame = self.fastLight.frame;
    frame.origin.y += 0.5;
    frame.origin.x -= 0.5;
    coverView = [[UIView alloc] init];
    coverView.frame = frame;
    coverView.backgroundColor = [UIColor grayColor];
    coverView.layer.cornerRadius = frame.size.width / 2;
    coverView.alpha = 0.5;
    [self.mMain addSubview:coverView];
    
    [lightTimer invalidate];
    lightTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(startLight) userInfo:nil repeats:true];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    sm.isConfiguration = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if(backView){
        [backView removeFromSuperview];
        [(AppDelegate *)([UIApplication sharedApplication].delegate) dismissMask];
    }
    
    for(UIView *view in self.mMain.subviews){
        [view.layer removeAllAnimations];
    }
    
    for(UIView *v in [UIApplication sharedApplication].keyWindow.subviews){
        if (v.tag == 999){
            [v removeFromSuperview];
        }
    }
    
    sm.controlTcp.mode = 0;
    if (![sm isConnected]) {
        [sm startSession];
    }
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self cancelAllTimer];
    if (smartConfig!=nil) {
        [smartConfig stopConfig];
    }
    
}
/**进入界面的导航##############################################################*/
-(void)firstStep{
    [self.mMain bringSubviewToFront:self.fastLight];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, self.fastLight.frame.origin.y + self.fastLight.frame.size.height, SCREEN_WIDTH, 80);
    label.numberOfLines = 0;
    label.text = @"长按设备按钮即可让指示灯处于快速模式\n并确保手机处于wifi连接模式";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.tag = 500;
    [self.mMain addSubview:label];
    [self.mMain bringSubviewToFront:label];
    
    CGFloat buttonWidth = self.btn_config.frame.size.width * 0.6;
    CGFloat buttnHeight = self.btn_config.frame.size.height * 2 / 3;
    CGFloat buttonX = (SCREEN_WIDTH - buttonWidth) / 2;
    CGFloat buttonY = label.frame.origin.y + label.frame.size.height;
    if([[UIScreen mainScreen] bounds].size.height == 480){
        buttonY = SCREEN_HEIGHT - 2 * buttnHeight;
    }else if([[UIScreen mainScreen] bounds].size.height == 568){
        buttonY = SCREEN_HEIGHT - buttnHeight - 5;
    }
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake( buttonX, buttonY, buttonWidth, buttnHeight);
    [button setBackgroundImage:[UIImage imageNamed:@"已连接按钮.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"已连接按钮按下.png"] forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(sureFastLight) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"已连接已快闪" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.tag = 501;
    
    //    CGFloat bolloonWidth = 115;
    //    CGFloat bolloonHeight = 100;
    //    CGFloat bolloonX = SCREEN_WIDTH / 2;
    //    CGFloat bolloonY = self.fastLight.frame.origin.y - 100;
    //    CGRect upRect = CGRectMake(bolloonX, bolloonY, bolloonWidth, bolloonHeight);
    //    Bolloon *bolloon = [[Bolloon alloc] initWithString:@"指示灯快闪" frame:upRect is:YES];
    //    bolloon.tag = 502;
    //    [self.mMain addSubview:bolloon];
    [self.mMain addSubview:button];
    [self.mMain bringSubviewToFront:button];
    [self.mMain bringSubviewToFront:_fastLight];
    
}

- (void)sureFastLight{
    for(UIView *view in self.mMain.subviews){
        if(view.tag == 500 || view.tag == 502 || view.tag == 501){
            [view removeFromSuperview];
        }
    }
    self.fastLight.hidden = YES;
    [self.fastLight removeFromSuperview];
    [self endLight];
    [self secondStep];
    //count++;
}

-(void)secondStep{
    
    //    [self.mMain bringSubviewToFront:self.img_pwdBack];
    [self.mMain bringSubviewToFront:self.tf_routerPwd];
    [self.mMain bringSubviewToFront:self.btn_showPwd];
    //    CGRect upRect = CGRectMake(self.view.frame.size.width / 2, self.tf_routerPwd.frame.origin.y - 100, 115, 100);
    //    Bolloon *bolloon = [[Bolloon alloc] initWithString:@"请输入Wi-Fi密码" frame:upRect is:YES];
    //    bolloon.tag = 503;
    //    [self.mMain addSubview:bolloon];
    
    
    
    CGFloat buttonWidth = self.btn_config.frame.size.width * 0.6;
    CGFloat buttnHeight = self.btn_config.frame.size.height *0.6;
    CGFloat buttonX = (SCREEN_WIDTH - buttonWidth) / 2;
    CGFloat buttonY = self.btn_config.frame.origin.y + self.btn_config.frame.size.height + 30;
    CGRect btnNextFrame = CGRectMake(buttonX, buttonY, buttonWidth, buttnHeight);
    UIButton *btnNext = [[UIButton alloc] init];
    btnNext.frame = btnNextFrame;
    [btnNext setBackgroundImage:[UIImage imageNamed:@"已连接按钮.png"] forState:UIControlStateNormal];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"已连接按钮按下.png"] forState:UIControlStateHighlighted];
    btnNext.backgroundColor = [UIColor clearColor];
    [btnNext addTarget:self action:@selector(sureInputPwd) forControlEvents:UIControlEventTouchUpInside];
    [btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnNext.tag = 504;
    
    [self.mMain addSubview:btnNext];
}
- (void)sureInputPwd{
    //    NSString * wifiname =[self.tf_routerPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    if (wifiname.length <=0) {
    //        [GlobalMethod toast:@"请输入路由器密码"];
    //        return;
    //    }
    
    for(UIView *view in self.mMain.subviews){
        if(view.tag == 503 || view.tag == 504){
            [view removeFromSuperview];
        }
    }
    
    [self overStep];
    
    
}
-(void)overStep{
    
    [self.tf_routerPwd resignFirstResponder];
    
    for(UIView *view in self.mMain.subviews){
        if(view.tag == 505 || view.tag == 506 || view.tag == 507){
            [view removeFromSuperview];
        }
        [backView removeFromSuperview];
        [(AppDelegate *)([UIApplication sharedApplication].delegate) dismissMask];
    }
    
    //    if (!self.isAirControl) {
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    //    }
    self.wifiImage.hidden = NO;
    
    CGFloat labelY = self.wifiImage.frame.origin.y + self.wifiImage.frame.size.height;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY + 10, SCREEN_WIDTH, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = self.tf_routerPwd.textColor;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"设备指示灯由慢闪变成常亮即配置成功";
    [self.mMain addSubview:label];
    
}
#pragma mark- 一键配置
//一键配置
////###########################################################################第一步：一键配置，发送路由器信息给设备

- (void)onceConfig:(UIButton *)sender{
    @try {
        self.wifiImage.hidden = NO;
        UIButton *btn = sender;
        if (btn == self.btn_config) {
            
            if (isConfigCancel) {
                isConfigCancel= NO;
                isConfig = NO;
                macAddress = @"";
                matchSuccess = NO;
                [self.btn_config setTitle:@"配置设备" forState:UIControlStateNormal];
                if (isSmartConfig) {
                    if (timerOut != nil) {
                        [timerOut invalidate];
                        timerOut = nil;
                    }
                    [smartConfig stopConfig];
                }else {
                    if (checkWifiCanUse != nil) {
                        [checkWifiCanUse invalidate];
                        checkWifiCanUse = nil;
                    }
                }
                isStop = NO;
                return;
            }else {
                isConfigCancel = YES;
                [self.btn_config setTitle:@"取消配置" forState:UIControlStateNormal];
            }
            
            isConfig = YES;
            checkWifiCount = 0;
            macAddress = @"";
            matchSuccess = NO;
            sm.isLogin = NO;
            
            [sm closeSession:YES];
            
            //[self performSelectorInBackground:@selector(ThreadSearch) withObject:nil];
            //一键配置等待5s之后在配置，否则第一次配置失败
            if (sm.controlTcp != nil) {
                [sm.controlTcp closeSocket];
            }
            isSmartConfig = YES;
            //        [self performSelector:@selector(test) withObject:nil afterDelay:3.0];
            [self smartConfig];
        }
    } @catch (NSException *exception) {
        [Util toast:[NSString stringWithFormat:@"异常：%@",exception]];
    } @finally {
        
    }
    
}

//-(void)test{
//    macAddress  = @"0558000000A3";
//    
//    
//    [self configSuccess:nil];
//}

- (void)smartConfig {
    [smartConfig startConfig:self.tf_ssid.text wifiPas:self.tf_routerPwd.text];
    timerOut = [NSTimer scheduledTimerWithTimeInterval:CONFIG_TIME_OUT target:self selector:@selector(configFailed) userInfo:nil repeats:NO];
    
}

//########################################################################SmartConfig代理

//第二步：发送成功之后，建立tcp连接，向设备发送服务器信息
- (void)configSuccess:(NSString *)mac host:(NSString *)host {
    
    
    if (mac == nil || mac.length == 0) {
        return;
    }
    macAddress  = mac;
    
    sm.controlTcp = [[ControlTcpSocket alloc]init];
    [sm.controlTcp startToConnectServer:host];
    sm.controlTcp.mode = 1;
    
    
    
//    NSString *ip = [SessionManger queryIpWithDomain:HOSTNAME];
//    if ([ip isEqual: @""]){
//        [GlobalMethod toast:@"连接失败请重试"];
//        return;
//    }
    
    NSArray *hosts = [sm.host componentsSeparatedByString:@"."];
    
    Byte hots[] = { [hosts[0] integerValue],[hosts[1] integerValue],[hosts[2]integerValue],[hosts[3] integerValue]};
    
    NSData *hostData = [NSData dataWithBytes:&hots length:4];
    
    int len = (int)[hostData length] + 3;
    Byte lenByte[] = {len-3};
    NSData *lenData = [NSData dataWithBytes:&lenByte length:1];
    
    int low = (PORT - 1) & 0xff;
    
    int high = (PORT - 1) >> 8;
    
    Byte portByte[] = {low, high};
    NSData *portData = [NSData dataWithBytes:&portByte length:2];
    
    NSMutableData *data = [[NSMutableData alloc]init];
    [data appendData:lenData];
    [data appendData:hostData];
    [data appendData:portData];
    
    [sm.controlTcp sendData:data];
}

- (void)configFailed {
    NSLog(@"一键配置失败");
    isConfig = NO;
    [self cancelConfigTimerOut];
    [GlobalMethod closePressDialog];
    isConfigCancel = YES;
    
    [self sendCmdTimeOut];
    
    isConfigCancel= NO;
    isConfig = NO;
    macAddress = @"";
    matchSuccess = NO;
    if (isSmartConfig) {
        if (timerOut != nil) {
            [timerOut invalidate];
            timerOut = nil;
        }
        [smartConfig stopConfig];
    }
    
}
-(void)sendCmdTimeOut{
    self.btn_config.enabled = YES;
    [self.btn_config setTitle:@"配置" forState:UIControlStateNormal];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    //[sm closeSession:YES];
    [self cancelAllTimer];
    [GlobalMethod closePressDialog];
    isStop = YES;
    NSLog(@"信号被外星人劫持了,请检查Wifi密码是否输入正确,若密码正确请把设备恢复出厂设置重新配置\n");
    [GlobalMethod toast:@"信号被外星人劫持了\n1.请检查Wifi密码是否输入正确\n2.若密码正确请把设备恢复出厂设置重新配置"];
}

-(void)cancelAllTimer{
    if (sendPacketTimer!=nil) {
        [sendPacketTimer invalidate];
        sendPacketTimer = nil;
    }
    if (checkWifiDisappearTimer != nil) {
        [checkWifiDisappearTimer invalidate];
        checkWifiDisappearTimer = nil;
    }
    if (addDeviceTimer != nil) {
        [addDeviceTimer invalidate];
        addDeviceTimer = nil;
    }
}
#pragma mark- 响应事件
- (IBAction)config:(id)sender {
    
    UIButton *btn = sender;
    [_tf_ssid resignFirstResponder];
    [_tf_routerPwd resignFirstResponder];
    if (btn == self.btn_config) {
        
        
        info = [GlobalMethod getNetworkInfo];
        NSString * name =[self.tf_ssid.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (name.length <=0) {
            [GlobalMethod toast:@"请连接至有效Wifi"];
            return;
        }
        
        //        NSString * wifiname =[self.tf_routerPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //        if (wifiname.length <=0) {
        //            [GlobalMethod toast:@"请输入路由器密码"];
        //            return;
        //        }
        
        //        NSString *roomName = [self.lb_roomName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //        if (roomName.length <= 0){
        //            [GlobalMethod toast:@"请选择房间"];
        //            return;
        //        }
        
        macAddress = nil;
    }
    
    NSUserDefaults *ud =  [NSUserDefaults standardUserDefaults];
    [ud setObject:_tf_routerPwd.text forKey:_tf_ssid.text];
    
    [ud synchronize];
    
    [self onceConfig:sender];
    //    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeDo) userInfo:nil repeats:false];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    btn.enabled = NO;
    [btn setTitle:@"配置中..." forState:(UIControlStateNormal)];
    
    
    //开始旋转动画
    [self startAnimation];
}

//-(void)timeDo{
//
////    self.- (void)configSuccess:(NSString *)mac host:(NSString *)host
//}

- (IBAction)showPassword:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 10){
        [self.tf_routerPwd setSecureTextEntry:YES];
        
        NSString *p = [[NSBundle mainBundle] resourcePath];
        NSString *path = [p stringByAppendingString:@"/记住密码按钮.png"];
        
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        btn.tag = 11;
    }else{
        [self.tf_routerPwd setSecureTextEntry:NO];
        
        NSString *p = [[NSBundle mainBundle] resourcePath];
        NSString *path = [p stringByAppendingString:@"/记住密码按钮按下.png"];
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        btn.tag = 10;
    }
}

-(void)tfReturn{
    [self.tf_ssid resignFirstResponder];
    [self.tf_routerPwd resignFirstResponder];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self tfReturn];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == self.tf_routerPwd){
        //        self.btn_showPwd.hidden = false;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == self.tf_routerPwd){
        NSString * wifiname =[self.tf_routerPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (wifiname.length <= 0) {
            //            self.btn_showPwd.hidden = true;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tfReturn];
    return true;
}

-(void)becomeActive:(NSNotificationCenter*)obj{
    
    info = [GlobalMethod getNetworkInfo];
    
}
-(void)enterBackGround:(NSNotificationCenter*)obj{
    [self tfReturn];
}

//网络改变 切换回ssid
- (void)reachabilityChanged: (NSNotification*)note {
    
    Reachability * reachability = [note object];
    if(![reachability isReachable]){
        [addDeviceTimer invalidate];
        addDeviceTimer = nil;
        NSLog(@"网络不可用");
    }else{
        NSLog(@"网络可用") ;
        [addDeviceTimer invalidate];
        addDeviceTimer = nil;
        [self removeAlertView];
        if (matchSuccess == YES) {
            [sm closeSession:YES];
            sm.mode = @"login";
            [sm startSession];
            sendCmdTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(sendCmdTimeOut) userInfo:nil repeats:YES];
        }
        matchSuccess = NO;
    }
    
    if (reach.isReachableViaWiFi) {
        NSLog(@"当前通过wifi连接") ;
    } else {
        NSLog(@"wifi未开启，不能用");
    }
    
    if (reach.isReachableViaWWAN) {
        NSLog(@"当前通过2g or 3g连接") ;
    } else {
        NSLog(@"2g or 3g网络未使用") ;
    }
}
-(void)removeAlertView{
    [networkAlertView dismissWithClickedButtonIndex:0 animated:NO];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    [wifiAlert dismissWithClickedButtonIndex:0 animated:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == alert){
        if(![alertView.title isEqualToString:@"配置失败"]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
        }
    }
}
#pragma mark- 配置导航和动画
/**配置动画##############################################################*/
-(void) startAnimation{
    self.wifiImage.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.wifiImage.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation{
    if(!isStop){
        angle += 10;
        [self startAnimation];
    }else{
        self.wifiImage.transform = CGAffineTransformMakeRotation(0);
        isStop = NO;
    }
}

-(void)startLight{
    if(coverView.alpha == 0.5){
        [UIView animateWithDuration:0.2 animations:^{
            coverView.alpha = 0;
        }];
        
    }else if(coverView.alpha == 0){
        [UIView animateWithDuration:0.2 animations:^{
            coverView.alpha = 0.5;
        }];
    }
}

-(void)endLight{
    [lightTimer invalidate];
    [coverView removeFromSuperview];
}
//#################################################################################

- (void)cancelConfigTimerOut {
    isConfigCancel = YES;
    [self.btn_config setTitle:@"配置" forState:UIControlStateNormal];
    if (timerOut != nil) {
        [timerOut invalidate];
        timerOut = nil;
    }
}

-(void)ThreadSearch{
    
    while (isConfig) {
        [NSThread sleepForTimeInterval:1];
    }
    
}

//###############################################################################
//#pragma mark- UINotification Center
//第三步：发送服务器信息给设备后，接收通知
- (void)configSuccess:(NSNotification*)noti {
    isConfig = NO;
    //[GlobalMethod toast:@"成功"];
    [self.btn_config setTitle:@"配置设备" forState:UIControlStateNormal];
    
    //    if (noti == nil) {//test
    //        isConfigCancel = NO;
    //        matchSuccess = YES;
    //
    //        [self cancelAllTimer];
    //        [timerOut invalidate];
    //        timerOut = nil;
    //
    //        if (isSmartConfig) {
    //            [sm closeSession:YES];
    //            [GlobalMethod showProgressDialog:@"添加..."];
    //            sm.mode = @"login";
    //            [sm startSession];
    //        }
    //        return;
    //    }
    
    
    NSString *status = [noti object];
    if ([status isEqualToString:@"1"]) {
        isConfigCancel = NO;
        matchSuccess = YES;
        
        [self cancelAllTimer];
        [timerOut invalidate];
        timerOut = nil;
        
        if (isSmartConfig) {
            [sm closeSession:YES];
            [GlobalMethod showProgressDialog:@"添加..."];
            sm.mode = @"login";
            sm.isConfiguration = YES;
            [sm startSession];
        }
        
    }else {
        matchSuccess = NO;
        if (isSmartConfig) {
            [self configFailed];
        }
        
    }
}


#pragma mark- NSNotificationCenter通知

-(void)receiveCMD:(NSNotification*)obj{
    sm.isLogin = YES;
    ServerCommand * cmd = [obj object];
    if (cmd->CommandNo == [CMD03_ServerLoginRespond commandConst]) {
        [sendCmdTimer invalidate];
        CMD03_ServerLoginRespond * cmd03 = (CMD03_ServerLoginRespond*)cmd;
        if (cmd03.result) {
            
            //NSArray *arr = [self.scanValue componentsSeparatedByString:@"-"];
            //NSString *snPwd = arr[1];
            sendCmdTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self
                                                          selector:@selector(sendCmdTimeOut) userInfo:nil repeats:NO];
            NSString *subMac;
            if (macAddress != nil && macAddress.length > 0) {
                if ([macAddress length] == 12){
                    subMac = [macAddress substringFromIndex:9];
                }else if(macAddress.length > 11){
                    subMac = [macAddress substringFromIndex:11];
                }else{
                    return;
                }
            }else{
                return;
            }
            NSLog(@"您所添加的设备mac:%@",macAddress);
            
            NSString *trueDname = [NSString stringWithFormat:@"药盒子-%@",subMac];
            
            
            
            CMD0C_AddMasterDevice * cmd0c = [[CMD0C_AddMasterDevice alloc] initWithPass:@"123" Mac:[NSString stringWithFormat:@"00%@",macAddress] Name:trueDname Place:@"" DeviceType:32];
            cmd0c.attach = @"";
            [[SessionManger shareSessionManger] sendCmd:cmd0c];
            //macAddress = nil;
            
        }
    }
    if (cmd->CommandNo == [CMD0D_ServerAddMasterDeviceResult commandConst]) {
        [sendCmdTimer invalidate];
        CMD0D_ServerAddMasterDeviceResult * cmd0d = (CMD0D_ServerAddMasterDeviceResult*)cmd;
        if (cmd0d.result == YES) {
            self.btn_config.enabled = YES;
            [self.btn_config setTitle:@"配置" forState:(UIControlStateNormal)];
            [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
            
//            [userDefaults setObject:macAddress forKey:macAddress];
            
            [Util toast:@"成功" WithColor:[UIColor greenColor]];
            isStop = YES;
            
            //            CMD16_QueryUserInfo *cmd16 = [[CMD16_QueryUserInfo alloc] init];
            //
            //            [sm sendCmd:cmd16];
            [self.navigationController popViewControllerAnimated:true];
        }else{
            [Util toast:@"设备添加失败"];
            [self cancelAllTimer];
        }
        
    }
    
    
    
}

-(void)receiveAllDevice:(NSNotification*)obj{
    [sendCmdTimer invalidate];
    [GlobalMethod closePressDialog];
    //    [udpSocket closeSocket];
    
    isStop = YES;
}

-(void)receiveFF:(NSNotification *)obj{
    self.btn_config.enabled = YES;
    [self.btn_config setTitle:@"配置" forState:(UIControlStateNormal)];
    self.btn_config.enabled = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    isStop = YES;
    [sendCmdTimer invalidate];
    [GlobalMethod closePressDialog];
    NSString * infoFF = [obj.object objectForKey:@"info"];
    
    if ([infoFF containsString:@"设备已被添加过"]){
        [Util toast:[NSString stringWithFormat:@"设备已被添加过\nSN:%@",macAddress]];
        [userDefaults setValue:@"true" forKey:@"tabIsReturnTo1"];
        [userDefaults synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:true];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefresh" object:nil];
        macAddress = nil;
    }else{
        [Util toast:infoFF];
    }
    
    sm.isLogin= NO;
    //    [udpSocket closeSocket];
}

#pragma mark - post请求代理
- (void)sendRequest:(NSString *)deviceJson{
    NSString *strURL = [NSString stringWithFormat:@"http://www.yourslink.com/shs-acquisition/userDeviceController.do"];
    NSString *post   = [NSString stringWithFormat:@"saveUserDevice&userDevice=%@&key=202cb962ac59075b964b07152d234b70",deviceJson];
    NSURL *url = [NSURL URLWithString:strURL];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connect) {
        _datas = [NSMutableData new];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"receive data");
    [_datas setLength:0];
    [_datas appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"finish loading");
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"返回信息%@",dict);
}

@end
