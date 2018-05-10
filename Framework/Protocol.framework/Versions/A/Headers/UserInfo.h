//
//  UserInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-5.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnsObject.h"
#import "BindOperation.h"
///User Information
@interface UserInfo : JSONObject

///user name
@property(nonatomic,strong) NSString* name;
///password
@property(nonatomic,strong) NSString* pass;
//电话
@property(nonatomic,strong) NSString* phone;
//e-mail
@property(nonatomic,strong) NSString* email;

//time zone
@property(nonatomic,assign) double offset;

//appid
@property(nonatomic,assign) int appid;

//User icon version
@property(nonatomic,assign) int iconVer;

///Third part(SNS) login id
@property(nonatomic,strong) NSArray<SnsObject *>* snsList;

///nickname
@property(nonatomic,strong) NSString* nickname;
@property(nonatomic,assign) BOOL enableWeChatPush;
@property(nonatomic,strong) NSArray<NSString *>* phoneGroup;
@property(nonatomic,strong) BindOperation* bindOperation;


-(id)initWithName:(NSString*)name_ Pass:(NSString*)pass_ Phone:(NSString*)phone_ Email:(NSString*)email_ Offset:(double)offset_ Appid:(int)appid SnsList:(NSArray*)snsList Nickname:(NSString*)nickname EnableWeChatPush:(BOOL)enableWeChatPush PhoneGroup:(NSArray<NSString *>*)phoneGroup;

@end
