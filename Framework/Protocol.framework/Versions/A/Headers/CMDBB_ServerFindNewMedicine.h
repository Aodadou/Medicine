//
//  CMDBB_ServerFindNewMedicine.h
//  Protocol
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "MedicineBox.h"

@interface CMDBB_ServerFindNewMedicine : ServerCommand
@property(strong,nonatomic) MedicineBox *medicineBox;
@end
