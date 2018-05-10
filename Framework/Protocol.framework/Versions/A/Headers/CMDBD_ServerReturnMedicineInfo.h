//
//  CMDBD_ServerReturnMedicineInfo.h
//  Protocol
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "MedicineInfo.h"
@interface CMDBD_ServerReturnMedicineInfo : ServerCommand
@property(strong,nonatomic) MedicineInfo * info;
@end
