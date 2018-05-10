//
//  MedicineInfo.h
//  Protocol
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 fortune. All rights reserved.
//

#import "JSONObject.h"
#import "DrugTimeScheme.h"
@interface MedicineInfo : JSONObject

@property(nonatomic,strong) NSString* rfid;//

@property(nonatomic,assign) BOOL isEdited;

@property(nonatomic,strong) NSString* name;//药品名称

@property(nonatomic,strong) NSString* imgUrl;//图片地址

@property(nonatomic,assign) NSInteger dosage;//剂量

@property(nonatomic,assign) NSInteger times;//每日次数

@property(nonatomic,assign) float price;//价格

@property(nonatomic,strong) NSString* code;//条形码

@property(nonatomic,strong) NSString* factory;//生产厂商

@property(nonatomic,strong) NSString* type;//药品类型

@property(nonatomic,strong) NSString* drugDescription;//药品描述

@property(nonatomic,strong) NSString* tag;//标签

@property(nonatomic,strong) NSString* message;//详细信息

@property(nonatomic,strong) NSString* url;//html地址

@property(nonatomic,strong) NSString* macId;
@property(nonatomic,strong) NSString* remark;
@property(nonatomic,strong) NSString* validityPeriod;

@property(nonatomic,strong) NSString* currentCount;
@property(nonatomic,strong) NSString* recordTime;
@property(nonatomic,assign) BOOL addReminder;
@property(nonatomic,assign) BOOL overdueReminder;
@property(nonatomic,strong) DrugTimeScheme *scheme;

@property(nonatomic,strong) NSString* editTime;
@property(nonatomic,strong) NSString* total;

//-(id)initRfid:(NSString*)rfid MacId:(NSString*)macId;
-(id)initWithRfid:(NSString*)rfid Name:(NSString*)name ImgUrl:(NSString*)imgUrl code:(NSString*)code Dosage:(NSInteger)dosage Times:(NSInteger)times Price:(float)price Factory:(NSString*)factory Type:(NSString*)type DrugDescription:(NSString*)drugDescription Tag:(NSString*)tag Message:(NSString*)message Url:(NSString*)url MacId:(NSString*)macId CurrentCount:(NSString*)currentCount ValidityPeriod:(NSString*)validityPeriod IsEdited:(BOOL)isEdit AddReminder:(BOOL)addReminder OverDueReminder:(BOOL)overdueReminder RecordTime:(NSString*)recordTime Remark:(NSString*)remark EditTime:(NSString*)editTime Total:(NSString*)total;

@end
