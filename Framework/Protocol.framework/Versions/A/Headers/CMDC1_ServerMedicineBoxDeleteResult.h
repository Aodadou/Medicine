//
//  CMDC1_ServerMedicineBoxDeleteResult.h
//  Protocol
//
//  Created by jxm on 2017/6/14.
//  Copyright © 2017年 fortune. All rights reserved.
//

#import "ServerCommand.h"

@interface CMDC1_ServerMedicineBoxDeleteResult : ServerCommand
@property(strong,nonatomic) NSString * macAddr;
-(id)initWithMacId:(NSString*)macId;
@end
