//
//  CMD9D_DeleteMedicine.h
//  Protocol
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"

@interface CMD9D_DeleteMedicine : ClientCommand
@property(nonatomic,strong) NSString* macId;
@property(nonatomic,strong) NSString* rfid;
@end
