//
//  Util.m
//  MagicLights
//
//  Created by chendy on 13-5-29.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Util.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation Util



+ (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}
/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
    return preferredLang;
}

#pragma mark－显示两位字符串
+(NSString*)numberTOString2:(NSInteger)value{
    NSString *str = nil;
    if (value < 10) {
        str = [NSString stringWithFormat:@"0%d",(int)value];
    }else{
        str = [NSString stringWithFormat:@"%d",(int)value];
    }
    return str;
}

+(void)toast:(NSString *)msg {
    [CRToastManager dismissNotification:NO];
    [CRToastManager showNotificationWithMessage:msg completionBlock:^(void){}];
}

+(void)toast:(NSString *)msg WithColor:(UIColor*)color{
    [CRToastManager dismissNotification:NO];
    [CRToastManager showNotificationWithOptions:@{kCRToastTextKey : msg,kCRToastBackgroundColorKey:color} completionBlock:^(void){}];
//    [CRToastManager showNotificationWithMessage:msg completionBlock:^(void){}];
}

+(BOOL)isIOS7  {
    float version=  [[UIDevice currentDevice].systemVersion floatValue];
    if (version >= 7.0) {
        return YES;
    }
    return NO;
}

+(UIColor*)getColor:(NSString*)hexColor{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



//十进制转换byte数组
+ (NSData *) dataFromHexString:(uint16_t)tmpid
{
    NSString * cleanString = [self cleanNonHexCharsFromHexString:[self ToHex:tmpid]];
    if (cleanString == nil) {
        return nil;
    }
    
    NSMutableData *result = [[NSMutableData alloc] init];
    
    int i = 0;
    for (i = 0; i+2 <= cleanString.length; i+=2) {
        NSRange range = NSMakeRange(i, 2);
        NSString* hexStr = [cleanString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        unsigned char uc = (unsigned char) intValue;
        [result appendBytes:&uc length:1];
    }
    NSData *data = [NSData dataWithData:result];
    return data;
}

/* Clean a hex string by removing spaces and 0x chars.
 . The hex string can be separated by space or not.
 . sample input: 23 3A F1; 233AF1; 0x23 0x3A 0xf1
 */

+(NSString *) cleanNonHexCharsFromHexString:(NSString *)input
{
    if (input == nil) {
        return nil;
    }
    
    if (input.length == 1) {
        input = [NSString stringWithFormat:@"000%@",input];
    }
    if (input.length == 3) {
        input = [NSString stringWithFormat:@"0%@",input];
    }

    NSString * output = [input stringByReplacingOccurrencesOfString:@"0x" withString:@""
                                                            options:NSCaseInsensitiveSearch range:NSMakeRange(0, input.length)];
    NSString * hexChars = @"0123456789abcdefABCDEF";
    NSCharacterSet *hexc = [NSCharacterSet characterSetWithCharactersInString:hexChars];
    NSCharacterSet *invalidHexc = [hexc invertedSet];
    NSString * allHex = [[output componentsSeparatedByCharactersInSet:invalidHexc] componentsJoinedByString:@""];
    return allHex;
}

+ (NSString *)getBinaryByhex:(NSString *)hex
{
    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    
    [hexDic setObject:@"0001" forKey:@"1"];
    
    [hexDic setObject:@"0010" forKey:@"2"];
    
    [hexDic setObject:@"0011" forKey:@"3"];
    
    [hexDic setObject:@"0100" forKey:@"4"];
    
    [hexDic setObject:@"0101" forKey:@"5"];
    
    [hexDic setObject:@"0110" forKey:@"6"];
    
    [hexDic setObject:@"0111" forKey:@"7"];
    
    [hexDic setObject:@"1000" forKey:@"8"];
    
    [hexDic setObject:@"1001" forKey:@"9"];
    
    [hexDic setObject:@"1010" forKey:@"A"];
    
    [hexDic setObject:@"1011" forKey:@"B"];
    
    [hexDic setObject:@"1100" forKey:@"C"];
    
    [hexDic setObject:@"1101" forKey:@"D"];
    
    [hexDic setObject:@"1110" forKey:@"E"];
    
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binaryString=[[NSString alloc] init];
    
    for (int i=0; i<[hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        
        //NSLog(@"%@",[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]);
        
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    NSLog(@"转化后的二进制为:%@",binaryString);
    
    return binaryString;
    
}

// 十进制转二进制
+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length
{
    NSString *a = @"";
    while (tmpid)
    {
        a = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:a];
        if (tmpid/2 < 1)
        {
            break;
        }
        tmpid = tmpid/2 ;
    }
    
    if (a.length <= length)
    {
        NSMutableString *b = [[NSMutableString alloc]init];;
        for (int i = 0; i < length - a.length; i++)
        {
            [b appendString:@"0"];
        }
        
        a = [b stringByAppendingString:a];
        
    }
    
    return a;
    
}
//十进制转十六进制
+ (NSString *)ToHex:(uint16_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

+(NSString *)getWifiSSID {
    id info = [self fetchNetworkInfo];
    NSString* ssid = [info objectForKey:@"SSID"];
    return ssid;
}



+(id)fetchNetworkInfo{
//    NSString * bssid, *ssid;
//    NSDate *ssiddata;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
#ifdef DEBUG
    NSLog(@"Supported interfaces: %@", ifs);
#endif
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
#ifdef DEBUG
        NSLog(@"%@ => %@", ifnam, info);
#endif
        if (info && [(NSDictionary*)info count]) {
//            bssid =[info objectForKey:@"BSSID"];
//            ssid = [info objectForKey:@"SSID"];
//            ssiddata = [info objectForKey:@"SSIDDATA"];
            break;
        }
    }
    return info;
}


+(UIImage*)getStretchableImage:(NSString *)imageNamed stretchableImageWidthLeftCapWidth:(NSInteger )width topCapHeight:(NSInteger)height {
    UIImage *image = [UIImage imageNamed:imageNamed];
    UIImage *stretchableImage = [image stretchableImageWithLeftCapWidth:width topCapHeight:height];
    return stretchableImage;
}


// 得到两点之间的弧度
+(float)getRad:(CGPoint) p1 orignalPoint:(CGPoint) p0 {
    // 算出斜边长
    float xie = [self calDistanceFromCircle:p1 orginalPoint:p0];
    // 得到这个角度的余弦值（通过三角函数中的定理：邻边/斜边=角度余弦值)
    float cosAngle = (p1.x-p0.x)/xie;
    // 通过反余弦定理获取到其角度的弧度
    float rad = (float)acosf(cosAngle);
    // 注意：当触屏的位置Y坐标<摇杆的Y坐标我们要取反值-0~180
    if(p0.y>p1.y) {
        rad = -rad;
    }
    return rad;
}

// 点到圆心的距离
+(float)calDistanceFromCircle:(CGPoint) p1 orginalPoint:(CGPoint) p0 {
    float x = p1.x - p0.x;
    float y = p1.y -p0.y;
    float d = sqrtf(powf(x, 2) + powf(y, 2));
    //    float d = hypotf(p1.x-p0.x, p1.y-p0.y);
    NSLog(@"distance is %f",d);
    return d;
}

//计算色带的值
+(float)calCircleValue:(float)angle {
    float temp = M_PI/2;
    if (angle>=-temp && angle<=temp) {
        angle += temp;
    } else {
        angle -= temp*3;
    }
    return angle*128/M_PI;
}
+ (NSString *)binaryToHex:(NSString *)binary {
    int number = [[self toDecimalSystemWithBinarySystem:binary] intValue];
    if (number < 16) {
        return [NSString stringWithFormat:@"0%@",[self ToHex:number]];
    }else {
        return [self ToHex:number];
    }
    
}
//  二进制转十进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum

{
    
    
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
        
    {
        
        return YES;
        
    }
    
    else
        
    {
        
        return NO;
        
    }
    
}

+(NSArray*)readJsons:(NSString*)msg{

   
    NSMutableString *strFile=[[NSMutableString alloc] initWithString:msg];
    NSMutableArray *arrayJson=[[NSMutableArray alloc] init];
    if (strFile.length<=4 ) {
        return arrayJson;
    }
    NSRange leftRange;
    NSRange rightRange;
    leftRange=[strFile rangeOfString:@"["];
    leftRange.length=leftRange.location+1;
    leftRange.location=0;
    [strFile deleteCharactersInRange:leftRange];
    rightRange=[strFile rangeOfString:@"]"];
    rightRange.length=[strFile length]-rightRange.location;
    [strFile deleteCharactersInRange:rightRange];
    // NSLog(@"%@",strFile);
    while(1)
    {
        NSString *tempString;
        NSDictionary *tempDictionary;
        rightRange=[strFile rangeOfString:@"}"];
        tempString=[strFile substringWithRange:NSMakeRange(0, rightRange.location+1)];
        NSData *tempData=[tempString dataUsingEncoding:NSUTF8StringEncoding];
        tempDictionary=[NSJSONSerialization JSONObjectWithData:tempData options:kNilOptions error:nil];
        [arrayJson addObject:tempDictionary];
        if([tempString isEqualToString:strFile])
            break;
        [strFile deleteCharactersInRange:NSMakeRange(0, rightRange.location+2)];
        
    }
    
    return arrayJson;
}

+(NSString*)dateFormatter:(NSDate*)date{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return  [dateformatter stringFromDate:date];
}
+(NSDate*)dateFormatterByString:(NSString*)date Format:(NSString*)format{
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //    [dateformatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    return  [dateformatter dateFromString:date];
}
+(NSString*)dateFormatter:(NSDate*)date Format:(NSString*)format{
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return  [dateformatter stringFromDate:date];
}
+(NSDate*)dateFormatterByString:(NSString*)date{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    NSDate *d = [dateformatter dateFromString:date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSTimeInterval interval = [zone secondsFromGMTForDate:d];
//    return [d dateByAddingTimeInterval:interval];
    
    return [dateformatter dateFromString:date];;
}

+(NSString*)timeFormatter:(NSDate*)date{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateformatter setDateFormat:@"HH:mm"];
    return  [dateformatter stringFromDate:date];
}
+(NSDate*)timeFormatterByString:(NSString*)date{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateformatter setDateFormat:@"HH:mm"];
    return  [dateformatter dateFromString:date];
}

+(NSMutableAttributedString*)showDifColorLabel:(UILabel*)lb Text:(NSString*)text Color:(UIColor*)color Rang:(NSRange)range Rang1:(NSRange)range1{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
   
    [str addAttribute:NSForegroundColorAttributeName value:color range:range1];
    lb.attributedText = str;
    return str;
}
@end
