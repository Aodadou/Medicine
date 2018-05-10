//
//  CMD9E_SendAddDrup.h
//  Protocol
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 fortune. All rights reserved.
//

#import "ServerCommand.h"

@interface CMD9E_ServerMedicineDeleteResult : ServerCommand<APPCommandProto>
@property(nonatomic,strong) NSString *macId;
@property(nonatomic,strong) NSString *rfid;



-(id)initWithMacId:(NSString*)macId Rfid:(NSString*)rfid;
//-(id)
@end
