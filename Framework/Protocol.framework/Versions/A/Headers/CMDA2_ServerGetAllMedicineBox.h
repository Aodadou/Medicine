//
//  CMDA2_DeleteDrupResult.h
//  Protocol
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "MedicineBox.h"
@interface CMDA2_ServerGetAllMedicineBox : ServerCommand<APPCommandProto>
@property(nonatomic,strong) NSArray<MedicineBox *>* list;
-(id)initWithList:(NSArray<MedicineBox *>*)list;
@end
