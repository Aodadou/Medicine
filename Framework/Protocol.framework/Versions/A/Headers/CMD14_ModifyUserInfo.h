//
//  CMD14_ModifyUserInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "UserInfo.h"

///The client to the server to send the request to modify user information
@interface CMD14_ModifyUserInfo : ClientCommand<APPCommandProto>

/**
 * which value should be modified<br>
 * 0: userName, 1:phoneNumber, 2:email, 3:bind SNS, 4:unbind SNS
 * ,5:nickName...
 */
@property(assign,nonatomic) int modifyType;

///Old value
@property(nonatomic,strong) UserInfo *oldValue;

///New value
@property(nonatomic,strong) UserInfo *value;

-(id)initWithModifyType:(int)modifyType OldValue:(UserInfo*)oldValue NewValue:(UserInfo*)newValue;

@end
