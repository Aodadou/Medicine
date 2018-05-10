//
//  CMD9F_EditMedicine.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"
#import "MedicineInfo.h"
@interface CMD9F_EditMedicine : ClientCommand
@property(nonatomic,strong) MedicineInfo *info;
@property(nonatomic,assign) NSInteger modifyType;//0是修改信息，1是修改定时
-(id)initWithModifyType:(NSInteger)type Info:(MedicineInfo*)info;
@end
