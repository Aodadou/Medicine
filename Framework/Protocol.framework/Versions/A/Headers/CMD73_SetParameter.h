//
//  CMD73_SetLocal.h
//  ClientProtocol
//
//  Created by chendy on 13-11-26.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends to the server parameter settings
@interface CMD73_SetParameter : ClientCommand<APPCommandProto>

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

-(id)initWithAPPID:(int)appid Locale:(NSString*)locale Platform:(NSString*)platform DeviceToke:(NSString*)deviceToken EnablePush:(BOOL)enablePush APPVer:(NSString*)appVer;

///Set current phone time in milliseconds
-(void)setPhoneTime;

@end
