//
//  CMD02_Login.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends login command
@interface CMD02_Login : ClientCommand<APPCommandProto>

///User name
@property(nonatomic,strong) NSString* username;

///Password
@property(nonatomic,strong) NSString* password;

///Time zone
@property(nonatomic,assign) double offset;

///Uniquely identify of APP
@property(nonatomic,assign) int appid;

///Third part(SNS) login id
@property(nonatomic,strong) NSString* snsId;

/**
 * The third part(SNS) login type<br>
 * 0:QQ, 1:weibo, 2:weixing, 3:renren
 */
@property(nonatomic,assign) int snsType;

-(id)initWithUser:(NSString*)user Pass:(NSString*)pass Offset:(double)offset appid:(int)appid;

-(id)initWithUid:(NSString*)snsId SnsType:(int)snsType Offset:(double)offset appid:(int)appid;

@end
