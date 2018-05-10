//
//  DCMD00_ServerStartConnect.h
//  Protocol
//
//  Created by chendy on 14-7-8.
//  Copyright (c) 2014年 fortune. All rights reserved.
//

#import "DServerCommand.h"

/**
 * Server initiates the connection.<br>
 * DCommand No. 00
 */
@interface DCMD00_ServerStartConnect : DServerCommand<DCommandProto>

/// Key(4)
@property(strong,nonatomic) NSData* key;

/// Server No(2)
@property(strong,nonatomic) NSData* serverNo;

-(id)initWithKey:(NSData*)key ServerNo:(NSData*)serverNo;

@end
