//
//  CMD0A_Register.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

/**
 * The client sends a registration request to the server <br>
 * <br>
 * Use CMD68 and CMD6A instead
 */
@interface CMD0A_Register : ClientCommand<APPCommandProto> 

///User name
@property(nonatomic,strong) NSString<expose>* username;

///Password
@property(nonatomic,strong) NSString<expose>* password;

///Phone number
@property(nonatomic,strong) NSString<expose>* phone;

///Email
@property(nonatomic,strong) NSString<expose>* email;


-(id)initWithUser:(NSString*) username Pass:(NSString*)password Phone:(NSString*)phone Email:(NSString*)email;

@end
