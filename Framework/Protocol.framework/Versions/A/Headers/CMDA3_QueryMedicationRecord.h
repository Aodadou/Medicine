//
//  CMDA3_QueryMedicationRecord.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"

@interface CMDA3_QueryMedicationRecord : ClientCommand
@property (nonatomic,strong) NSString* macId;
@property (nonatomic,strong) NSString* date;
-(id)initWithMacId:(NSString*)macId Date:(NSString*)date;
@end
