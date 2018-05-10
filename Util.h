//
//  Util.h
//  MagicLights
//
//  Created by chendy on 13-5-29.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CRToast/CRToast.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? YES : NO)

@interface Util : NSObject<UIAlertViewDelegate>
+(NSDate*)dateFormatterByString:(NSString*)date Format:(NSString*)format;
+(NSString*)dateFormatter:(NSDate*)date Format:(NSString*)format;

+ (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2;
+(NSString*)numberTOString2:(NSInteger)value;
+(void)toast:(NSString *)msg WithColor:(UIColor*)color;
//toast消息
+(void)toast:(NSString*)msg;
//+(void)longToast:(NSString*)msg;
+(UIColor*)getColor:(NSString*)hexColor;
+(BOOL)isIOS7 ;
+ (NSData *) dataFromHexString:(uint16_t)tmpid;
+(NSString *)getWifiSSID;
// 十六进制转二进制
+ (NSString *)getBinaryByhex:(NSString *)hex;
// 十进制转二进制
+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length;
//十进制转十六进制
+ (NSString *)ToHex:(uint16_t)tmpid;
//二进制转十六进制
+ (NSString *)binaryToHex:(NSString *)binary;
//  二进制转十进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;
+(UIImage*)getStretchableImage:(NSString*)imageNamed stretchableImageWidthLeftCapWidth:(NSInteger)width topCapHeight:(NSInteger)height;
//// 设置按钮在不同状态的背景色
//+(void)setButtonBackground:(UIButton*)button normalImage:(NSString*)imageNameNormal pressedImage:(NSString*)imageNamePressed;
// 点到圆心的距离
+(float)calDistanceFromCircle:(CGPoint) p1 orginalPoint:(CGPoint) p0;
// 得到两点之间的弧度
+(float)getRad:(CGPoint) p1 orignalPoint:(CGPoint) p0;
//计算色带的值
+(float)calCircleValue:(float)angle;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)getPreferredLanguage;

+(NSArray*)readJsons:(NSString*)msg;
+(NSString*)dateFormatter:(NSDate*)date;
+(NSDate*)dateFormatterByString:(NSString*)date;
+(NSString*)timeFormatter:(NSDate*)date;
+(NSDate*)timeFormatterByString:(NSString*)date;
+(NSMutableAttributedString*)showDifColorLabel:(UILabel*)lb Text:(NSString*)text Color:(UIColor*)color Rang:(NSRange)range Rang1:(NSRange)range1;
//+(id)copyInstance:(NSObject*)obj;
@end
