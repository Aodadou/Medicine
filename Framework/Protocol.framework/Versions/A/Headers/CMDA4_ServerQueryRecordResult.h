//
//  CMDA4_ServerQueryRecordResult.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "MedicationRecord.h"
@interface CMDA4_ServerQueryRecordResult : ServerCommand

@property(nonatomic,strong) NSArray<MedicationRecord *>* list;//MedicationRecord

-(id)initWithList:(NSArray*)list;

@end
