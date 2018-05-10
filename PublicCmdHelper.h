//
//  MyCmdHelper.h
//  HomiSmart
//
//  Created by David Huang on 13-11-22.
//  Copyright (c) 2013年 David Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Protocol/CMDHelper.h>
#import <Protocol/CMD00_ConnectRequet.h>
#import <Protocol/CMD02_Login.h>
#import <Protocol/CMD04_GetAllDeviceList.h>
#import <Protocol/CMD08_ControlDevice.h>
#import <Protocol/CMD09_ServerControlResult.h>
#import <Protocol/CMD0A_Register.h>
#import <Protocol/CMD0C_AddMasterDevice.h>
#import <Protocol/CMD0E_AddSlaveDevice.h>
#import <Protocol/CMD10_DelDevice.h>
#import <Protocol/CMD12_ModifyDevice.h>
#import <Protocol/CMD18_AddTimerTask.h>
#import <Protocol/CMD20_ModifyTimer.h>
#import <Protocol/CMD22_DelTimer.h>
#import <Protocol/CMD24_QueryTimer.h>
#import <Protocol/CMD62_ForgetPassWithVerifySetup1.h>
#import <Protocol/CMD64_ForgetPassWithVerifySetup2.h>
#import <Protocol/CMD66_CheckUsername.h>
#import <Protocol/CMD58_ChangePwd.h>
#import <Protocol/CMD60_ForgetPwd.h>
#import <Protocol/CMD6A_RegisterWithVerifySetup2.h>
#import <Protocol/CMD68_RegisterWithVerifySetup1.h>
#import <Protocol/CMD6C_ControlIRDeviceMode.h>
#import <Protocol/CMD6F_IRBingSetup2.h>
#import <Protocol/CMD71_VerifyCode.h>
#import <Protocol/CMD73_SetParameter.h>
#import <Protocol/CMDFC_IdleSucc.h>
#import <Protocol/CMDFF_ServerException.h>

#define airDeviceType 0

//busy通知名
#define NOTIFY_BUSY @"notify_busy"
//间隔发送时间
#define GAPTIME 2

//保存上次发送CMD的KEY
#define RECORD_CMD @"record_cmd"



@interface PublicCmdHelper : NSObject
//取得单例
+(PublicCmdHelper*)sharePublicCmdHelperInstance;

//是否开始发送8号指令队列
@property (atomic,assign) BOOL startSendCMD8;
//CMDHelper
@property (nonatomic,strong)CMDHelper *helper;

//开始发送8号指令队列（需要先设置startSendCMD8为YES,最好在viewWillAppear调用）
-(void)startSendCMD8Thread;
//关闭8号指令队列（最好在viewWillDisappear调用)
-(void)stopSendCMDThread;

//发送08号控制指令，NeedDelay表示是否需要延迟3秒刷新（对滑动开关设为YES)
-(void)sendCMD08WithStatus:(Device*)status NeedDelay:(BOOL)delay;

//--------------下列是有做BUSY处理的命令

//删除下挂设备
-(void)sendCMD10WithDevid:(NSString*)devid;
//添加主设备
-(void)sendCMD0CWithPass:(NSString*)pass MAC:(NSString*)mac Name:(NSString*)name Place:(NSString*)place;
//添加下挂设备
-(void)sendCMD0EWithPass:(NSString*)pass SN:(NSString*)sn Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Type:(int)type SubType:(NSString*)subType;
//修改密码
-(void)sendCMD58WithUsername:(NSString*)username OldPass:(NSString*)oldPass NewPass:(NSString*)newPass;
//传统的忘记密码
-(void)sendCMD60WithUsername:(NSString*)username Email:(NSString*)email;
//忘记密码第一步
-(void)sendCMD62WithUsername:(NSString*)username Email:(NSString*)email  Phone:(NSString*)phone;
//忘记密码第二步
-(void)sendCMD64WithUsername:(NSString*)username Email:(NSString*)email Pass:(NSString*)pass Uuid:(NSString*)uuid Code:(NSString*)code  Phone:(NSString*)phone;
//查看用户名是否使用
-(void)sendCMD66WithUsername:(NSString*)username;
//注册第一步
-(void)sendCMD68WithUsername:(NSString *)username Email:(NSString *)email  Phone:(NSString*)phone;
//注册第二步
-(void)sendCMD6AWithUsername:(NSString*)username Pass:(NSString*)pass Phone:(NSString*)phone Email:(NSString*)email UUID:(NSString*)uuid Code:(NSString*)code;
//确认验证码是否正确
-(void)sendCMD71WithUUID:(NSString*)uuid Code:(NSString*)code;

//---------------------------------------

//----------------下列是不用做BUSY处理的命令，传入参数就可以发送了

-(void)sendCMD00;

-(void)sendCMD02WithUser:(NSString*)user Pass:(NSString*)pass Offset:(int)offset appid:(int)appid;

-(void)sendCMD04;

-(void)sendCMD0AWithUser:(NSString*) username Pass:(NSString*)password Phone:(NSString*)phone Email:(NSString*)email;

-(void)sendCMD12WithDevid:(NSString*)devid Name:(NSString*)name Place:(NSString*)place;

-(void)sendCMD18WithSchedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo;

-(void)sendCMD20WithSchedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo;

-(void)sendCMD22WithSchedid:(NSString*)schedid;

-(void)sendCMD24WithDevid:(NSString*)devid;

-(void)sendCMD6CWithSN:(NSString *)sn Mode:(int)mode;

-(void)sendCMD6FWithSN:(NSString *)sn Button:(int)button;

-(void)sendCMD73WithAPPID:(int)appID Locale:(NSString*)locale;

-(void)sendCMDFC;

@end
