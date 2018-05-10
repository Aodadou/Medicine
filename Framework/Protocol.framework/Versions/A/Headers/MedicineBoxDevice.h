//
//  MedicineBoxDevice.h
//  Protocol
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 fortune. All rights reserved.
//

#import "CommonDevice.h"

@interface MedicineBoxDevice : CommonDevice
@property(nonatomic,strong) NSArray<NSString*> *rfids;//<String[]>

@end
