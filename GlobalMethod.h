//
//  GlobalMethod.h
//  Lede
//
//  Created by apple on 13-10-12.
//  Copyright (c) 2013年 lede. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
//#import "TTFadeSwitch.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? YES : NO)
#define IS_IOS_7 (DeviceSystemMajorVersion() >= 7)
@interface GlobalMethod : NSObject{
      
}
@property(nonatomic)MBProgressHUD* HUD;

NSUInteger DeviceSystemMajorVersion();

// 处理图片
//+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

// 十进制转十六进制
+ (NSString *)toHex:(int)num;

//判断当前设备是否是ipad
+(BOOL)isIpad;
//初始化navigationItem 的title 字体颜色
+(void)initNavigationItem:(UINavigationItem*)item navigationBar:(UINavigationBar*)bar ;
//设置textfield的光标位置
+(void)setTextFieldLeftView:(UITextField*)tf;
//当textfield 操作软键盘挡住界面时，滚动屏幕
+(void)scrollScreen:(UITextField*)tf view:(UIView*)view offset:(float)offset;
//toast消息
+(void)toast:(NSString*)msg;
//弹出等待框
+(void)showConfiguProgressDialog;
//弹出等待框
+(void)showProgressDialog:(NSString*)value;
//关闭等待框
+(void)closePressDialog;
//获取正在使用的Wi-Fi名称
+(id)getNetworkInfo;
//把从设备中读出的macAddress: 形如  1c:7e:e5:53:7a:42 变成 1c7ee5537a42
+(NSString *)cutMacAddressString:(NSString *)macAddress;

//获得某个NSDate 中的具体信息
+(NSDateComponents*)getDateComponents;
//计算收到40 号FFbusy 指令时重新发送指令的间隔
+(int)getRetryTimer:(int)times;
@end
