//
//  GlobalMethod.m
//  Lede
//
//  Created by apple on 13-10-12.
//  Copyright (c) 2013年 lede. All rights reserved.
//

#import "GlobalMethod.h"
#import "CRToast.h"
#import "SessionManger.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NEHotspotHelper.h>
static MBProgressHUD * HUD;
@implementation GlobalMethod {
    
}

NSUInteger DeviceSystemMajorVersion()
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

+(BOOL)isIpad {
    return [[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad;
}




+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //    UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)toHex:(int)num
{
    NSString *hexString;
    if (num < 16) {
        hexString = [NSString stringWithFormat:@"0%@",[[NSString alloc] initWithFormat:@"%1x", num]];
    } else {
        hexString = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x", num]];
    }
    return hexString;
}

+(void)initNavigationItem:(UINavigationItem*)item navigationBar:(UINavigationBar*)bar {
    bar.bounds =CGRectMake(0, 0, bar.frame.size.width, bar.frame.size.height);
    //设置Navigation Bar背景图片
    UIImage *title_bg = [UIImage imageNamed:@"注册步骤背景"];  //获取图片
    CGSize titleSize = bar.bounds.size;  //获取Navigation Bar的位置和大小
    if (iPad) {
        if (IS_IOS_7) {
            titleSize.height += 20;
        }else{
            
        }
    }else{
        if (IS_IOS_7) {
            titleSize.height +=20;
        }else{
            
        }
    }
    title_bg = [self imageWithImage:title_bg scaledToSize:titleSize];//设置图片的大小与Navigation Bar相同
    UIImage * lineImg = [UIImage imageNamed:@"b"];
    UIImageView * bgView = [[UIImageView alloc] initWithImage:lineImg];
    bgView.frame = CGRectMake(0, bar.frame.size.height, bar.frame.size.width, 1);
    [bar addSubview:bgView];
    [bar setBackgroundImage:title_bg
     forBarMetrics:UIBarMetricsDefault];  //设置背景

    UIColor * cc = [UIColor whiteColor];
    UIFont * iphoneFont = [UIFont boldSystemFontOfSize:16];
    UIFont * ipadFont = [UIFont boldSystemFontOfSize:28];
    NSArray * value;
    if ([GlobalMethod isIpad]) {
        value= [[NSArray alloc] initWithObjects:cc,ipadFont, nil];
    }else{
        value= [[NSArray alloc] initWithObjects:cc,iphoneFont, nil];
    }
    
    NSArray *key = [[NSArray alloc] initWithObjects:UITextAttributeTextColor,UITextAttributeFont, nil];
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:value forKeys:key];
    bar.titleTextAttributes = dict;
}
+(void)setTextFieldLeftView:(UITextField*)tf{
    if ([self isIpad]) {
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)] ;
    }else{
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)] ;
    }
    
    tf.leftView.userInteractionEnabled = NO;
    tf.leftViewMode = UITextFieldViewModeAlways;
}
+(void)scrollScreen:(UITextField*)tf view:(UIView*)view offset:(float)offset{
    if (offset > 0) {
        offset += 50;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:.3f];
        CGRect sf = view.frame;
        sf.origin.y = view.frame.origin.y - offset;
        view.frame = sf;
        [UIView commitAnimations];
    }else if (offset <0){
        offset -= 50;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:.3f];
        CGRect sf = view.frame;
        sf.origin.y = view.frame.origin.y - offset;
        view.frame = sf;
        [UIView commitAnimations];
    }else{
        
    }
}
+(void)toast:(NSString *)msg {
    [CRToastManager dismissNotification:NO];
    [CRToastManager showNotificationWithMessage:msg completionBlock:^(void){}];
//    [OMGToast showWithText:msg bottomOffset:100];
}
+(void)showConfiguProgressDialog{
    if (HUD != nil) {
        [self closePressDialog];
    }
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
    HUD.labelText = NSLocalizedString(@"config", nil);
    HUD.labelFont = [UIFont systemFontOfSize:14];
    [HUD show:YES];
}
//弹出等待框
+(void)showProgressDialog:(NSString*)value {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (HUD != nil) {
        [self closePressDialog];
    }
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
    HUD.labelText = value;
    [HUD show:YES];
}
//关闭等待框
+(void)closePressDialog {
    [HUD removeFromSuperview];
    HUD = nil;
}


+(id)getNetworkInfo{
    NSString * bssid, *ssid;
    NSDate *ssiddata;
    
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [(NSDictionary*)info count]) {
            bssid =[info objectForKey:@"BSSID"];
            ssid = [info objectForKey:@"SSID"];
            ssiddata = [info objectForKey:@"SSIDDATA"];
            break;
        }
    }
    return info;
}
//把从设备中读出的macAddress: 形如  1c:7e:e5:53:7a:42 变成 1c7ee5537a42

+(NSString *)cutMacAddressString:(NSString *)macAddress {
    NSArray *array = [macAddress componentsSeparatedByString:@":"];
    NSMutableString *one = [NSMutableString stringWithFormat:@"%@",array[0]];
    if (one.length < 2) {
        [one insertString:@"0" atIndex:0];
    }
    NSMutableString *two = [NSMutableString stringWithFormat:@"%@",array[1]];
    if (two.length < 2) {
        [two insertString:@"0" atIndex:0];
    }
    NSMutableString *three = [NSMutableString stringWithFormat:@"%@",array[2]];
    if (three.length < 2) {
        [three insertString:@"0" atIndex:0];
    }
    NSMutableString *four = [NSMutableString stringWithFormat:@"%@",array[3]];
    if (four.length < 2) {
        [four insertString:@"0" atIndex:0];
    }
    NSMutableString *five = [NSMutableString stringWithFormat:@"%@",array[4]];
    if (five.length < 2) {
        [five insertString:@"0" atIndex:0];
    }
    NSMutableString *six = [NSMutableString stringWithFormat:@"%@",array[5]];
    if (six.length < 2) {
        [six insertString:@"0" atIndex:0];
    }
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",one,two,three,four,five,six];
}


//获得某个NSDate 中的具体信息
+(NSDateComponents*)getDateComponents{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    return  components;
}
//计算收到40 号FFbusy 指令时重新发送指令的间隔
+(int)getRetryTimer:(int)times{
    return (GAP_TIMER*((int)(times/2)+1));
}
@end
