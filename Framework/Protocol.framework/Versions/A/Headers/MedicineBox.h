//
//  MedicineBox.h
//  Protocol
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "JSONObject.h"
#import "MedicineInfo.h"
#import "DrugTimeScheme.h"
@interface MedicineBox : JSONObject

@property(nonatomic,strong) NSString* macId;
@property(nonatomic,strong) NSArray<MedicineInfo *>* list;// List<MedicineInfo>

@property(nonatomic,assign) int iconVer;
-(id)initWithMacId:(NSString*)macId List:(NSArray<MedicineInfo *>*)list IconVer:(int)iconVer;
@end
