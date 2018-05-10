//
//  CMD74_ServerSetLocaleSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-11-26.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ServerCommand.h"

///The server returns parameter setting success
@interface CMD74_ServerReturnParameter : ServerCommand<APPCommandProto>

///APPID
@property(nonatomic,strong) NSNumber<expose>* appid;

///locale (International standards, en: English, ch: Chinese)
@property(nonatomic,strong) NSString<expose>* locale;

/**
 * Platform<br>
 * a:andrid，i:iphone，w:winphone
 */
@property(nonatomic,strong) NSString<expose>* platform;

///Apparatus token (using push)
@property(nonatomic,strong) NSString<expose>* deviceToken;
///Apparatus token (using push)
@property(nonatomic,strong) NSString<expose>* serverTime;
/**
 * EnablePush<br>
 * 0:Disable,1:Enable
 */
@property(nonatomic,strong) NSNumber<expose>* enablePush;

/**
 * Phone current time<br>
 * If set, use relative time to set timer<br>
 * measured in milliseconds, between the current time and midnight, January
 * 1, 1970 UTC.
 */
@property(nonatomic,strong) NSNumber<expose>* phoneTime;

/// APP version
@property(strong,nonatomic) NSString<expose>* appVer;

/// Protocol Version
@property(strong,nonatomic) NSString<expose>* protoVer;

/// Image server URL
@property(nonatomic,strong) NSString<expose>* imageServer;

/// Statistic server URL
@property(nonatomic,strong) NSString<expose>* statisticServer;

/// APP latest version
@property(nonatomic,strong) NSString<expose>* appLatestVer;

/// APP download URL
@property(nonatomic,strong) NSString<expose>* appLatestURL;

-(id)initWithAPPID:(int)appid Locale:(NSString*)locale Platform:(NSString*)platform DeviceToke:(NSString*)deviceToken EnablePush:(BOOL)enablePush APPVer:(NSString*)appVer ImageServer:(NSString*)imageServer StatisticServer:(NSString*)statisticServer AppLatestVer:(NSString*)appLatestVer AppLatestURL:(NSString*)appLatestURL ServerTime:(NSString*)serverTime;

@end
