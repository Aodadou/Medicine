//
//  GlobalData.m
//  WiFiPlug
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 zcl. All rights reserved.
//

#import "MyGlobalData.h"
static NSMutableArray * deviceList;
static NSMutableArray *groupList;
static NSMutableArray * timerList;
static NSMutableDictionary * timerDictionary;


//static DeviceStatus * selectedDevice;
static GroupInfo * selectedGroupInfo;
static int operateType;//1 表示 对单个设备操作， 2 表示对组操作
static int operateModel;//1 表示修改模式， 2 表示添加模式
static BOOL isManual;//yes 表示手动， no 表示其他情况返回的09 号指令
static BOOL isGroupManual;//yes 表示手动， no 表示其他情况返回的8e 号指令
@implementation MyGlobalData
+(NSMutableArray*)getDeviceList{
    return deviceList;
}
+(void)setDeviceList:(NSMutableArray*)list{
    deviceList = list;
}

+(NSMutableArray*)getGroupList{
    return  groupList;
}
+(void)setGroupList:(NSMutableArray*)list{
    groupList = list;
}

+(NSMutableArray*)getTimerList{
    return timerList;
}
+(void)setTimerList:(NSMutableArray*)list{
    timerList = list;
}
+(NSMutableDictionary*)getTimerDictronary{
    if (timerDictionary == nil) {
        timerDictionary = [[NSMutableDictionary alloc]init];
    }
    return timerDictionary;
}
+(void)setTimerDictronary:(NSMutableDictionary*)dic{
    timerDictionary = dic;
}
//+(DeviceStatus*)getSelectedDeviceStatus{
//       return  selectedDevice;
//}
//+(void)setSelectedDeviceStatus:(DeviceStatus*)device{
//      selectedDevice = device;
//}
+(GroupInfo*)getSelectedGroupInfo{
    return selectedGroupInfo;
}
+(void)setSelectedGroupInfo:(GroupInfo*)groupInfo{
    selectedGroupInfo = groupInfo;
}

+(int)getOperateType{
    return operateType;
}
+(void)setOperateType:(int)type{
    operateType = type;
}
+(int)getOperateModel{
    return operateModel;
}
+(void)setOperateModel:(int)model{
    operateModel = model;
}
//判断是否手动控制主界面的开关
+(BOOL)getIsManual{
    return isManual;
}
+(void)setIsManual:(BOOL)manual{
    isManual = manual;
}
//判断是否手动控制主界面的组开关
+(BOOL)getIsGroupManual{
    return isGroupManual;
}
+(void)setIsGroupManual:(BOOL)manual{
    isGroupManual = manual;
}
@end
