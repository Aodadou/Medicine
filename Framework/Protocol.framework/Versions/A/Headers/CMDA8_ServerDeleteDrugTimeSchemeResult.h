//
//  CMDA8_ServerDeleteDrugTimerResult.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"

@interface CMDA8_ServerDeleteDrugTimeSchemeResult : ServerCommand
@property (nonatomic,strong) NSString* macId;
@property (nonatomic,strong) NSString* rfid;


-(id)initWithMacId:(NSString*)mac Rfid:(NSString*)rfid ;
@end
