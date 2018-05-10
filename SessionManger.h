//
//  LoginViewController.h
//  WiFiPlug
//
//  Created by apple on 13-11-9.
//  Copyright (c) 2013年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Protocol/Protocol.h>
#import <UIKit/UIKit.h>
#import "ControlTcpSocket.h"
#import "ASIHTTPHelper.h"

//域名转IP
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>  


#define NOTIFY_GETALLDEVICE @"getAllDevice"
#define NOTIFY_UPDATE_APP @"need_update"
#define NOTIFY_REC_FF @"Receive_FF"

#define NOTIFY_REC_CMD @"after receive cmd"
#define NOTIFY_REFRESH_UPHOTO @"refresh"
#define MedicineBoxDeviceType 32
#define APPVersion @"1.0"
//09/13号指令通知名
#define NOTIFY_REFRESH_DEVICE_STATES @"notify_refresh_device_states"
#define NOTIFY_RECEIVE_ALL_TIMER @"receive all timers"
//收到40号错误指令时需要处理的参数
#define GAP_TIMER 2
#define MAX_RETRY_TIMES 5;
//------------
#define VERSION  @"1.00"
#define URL_GET_DPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/getDeviceImage?token=%@",IMAGE_SERVER,TOKEN]

#define URL_UP_DPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/upDeviceImage?token=%@",IMAGE_SERVER,TOKEN]

//#define URL_GET_UPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/getUserImage?token=%@",IMAGE_SERVER,TOKEN]

//#define URL_UP_UPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/upUserImage?token=%@",IMAGE_SERVER,TOKEN]

#define TOKEN_DEVICE(name,pwd,mac) [NSString stringWithFormat:@"name=%@&pwd=%@&appId=0&deviceSn=%@",name,pwd,mac]
//#define TOKEN_USER(name,pwd) [NSString stringWithFormat:@"name=%@&pwd=%@&appId=1",name,pwd]

//#define Wifi_Name @"wifino1"
//----------

static NSString *HOSTNAME = @"mbox.yourslink.com";

//#define HOST @"112.74.24.235"
#define PORT 10227

#define USER @"zzc"
#define PASS @"666"
//Idle发送的时间间隔
#define IDLE_DURATION 30
//检测发送Idle是否成功的超时时间
#define TIME_OUT 10
//通知LED灯的状态改变
#define NOTIFY_STATUS_CHANGE @"Status_Changed"
//通知socket已连接上
#define NOTIFY_CONNECT @"Connect"
//通知网络已登陆成功
#define NOTIFY_LOGIN @"Login"
//通知注销成功
#define NOTIFY_LOGOUT @"Logout"
//通知网络断开
#define NOTIFY_DISCONNECT @"Disconnect"

//#define NOTIFY_ALL_DRUG @"receiveAllDrug"
//#define NOTIFY_ALL_PATIONINFOS @"receiveAllPationInfos"
@interface SessionManger : NSObject<UIAlertViewDelegate,CMDHelperDelegate,ASIHTTPRequestDelegate> {
    //用户名
    NSString* _username;
    //密码
    NSString* _password;
    //是否自动登陆
    BOOL _autoLogin;
    //按下back
    BOOL _backDown;
    //是否登陆
    BOOL _isLogin;
    //是否连接到服务器
    BOOL _isConnected;
    //保持在线
    BOOL _stayOnline;
    BOOL isConfiguration;
    NSString *_host;
    NSInteger port;
    NSString* _reg_account;
    NSString* _reg_phone;
    NSString* _reg_email;
    NSString* _reg_password;
    NSString *_reg_uuid;
    NSString * _reg_code;
    
    NSString* _find_account;
    NSString* _find_email;
    NSString *_mode;
    
    int appid;
    NSDictionary *errorDic;
    //手机数据库中所有灯的数据，以MacAddr为key的方式存储，以便从网络上取得数据后与此数据进行匹配赋值
    NSDictionary* _LEDMap;
    //程序是否后台运行
    BOOL _isBackground;
    NSString *dWifiName;
   
}

@property(nonatomic,strong) NSMutableString *onlineMacString;

@property(nonatomic,strong) NSMutableDictionary *pationImages;
@property(nonatomic,strong) NSMutableArray<MedicineBox *> *medicineBoxs;//
@property(nonatomic,strong) NSMutableDictionary* pationInfos;
//@property(nonatomic,strong) NSArray<DrugTimeScheme *> *drugTimes;//
@property(nonatomic,strong) NSString *currentDid;

@property(nonatomic,strong) ControlTcpSocket *controlTcp;
@property(nonatomic,strong)NSString* username;
@property(nonatomic,strong)NSString* password;
@property(nonatomic,strong)NSString* reg_account;
@property(nonatomic,strong)NSString* reg_phone;
@property(nonatomic,strong)NSString* reg_email;
@property(nonatomic,strong)NSString* reg_password;
@property(nonatomic,strong)NSString * reg_uuid;
@property(nonatomic,strong)NSString * reg_code;
@property(nonatomic,strong)NSString* find_account;
@property(nonatomic,strong)NSString* find_email;
@property(nonatomic,strong)NSString* host;
@property(nonatomic,strong)NSString* jpsCity;
@property(nonatomic)NSInteger port;
@property(nonatomic,strong)NSString* mode;
@property(nonatomic,strong)UserInfo *userInfo;
@property(nonatomic,assign)BOOL autoLogin;
@property(nonatomic,assign)BOOL backDown;
@property(nonatomic,assign)BOOL stayOnline;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,assign,readonly)BOOL isConnected;
@property(nonatomic,weak)id delegate;
@property(nonatomic,strong)NSData* TDES_KEY;
@property(nonatomic,assign)BOOL isBackground;
@property(nonatomic,assign)BOOL isConfiguration;
@property(nonatomic,strong) CMD74_ServerReturnParameter *cmd74;
@property(nonatomic,strong)NSString* url_img;

-(MedicineBox*)getCurrentDevice;
//开始回话
-(void)startSession;

//关闭一个会话,是否需要通知
-(void)closeSession:(BOOL)sendAction;
-(void)closeSocket;
-(void)cancelAllTimer;
//得到一个实例
+(SessionManger*)shareSessionManger;
-(void)sendCmd:(ClientCommand * )cmd;
-(void)cancel09and8eTimer;//取消09号和8e定时器

+(NSString *)queryIpWithDomain:(NSString *)domain;

@end
