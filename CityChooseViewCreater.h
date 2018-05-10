//
//  CityChooseViewCreater.h
//  Json
//
//  Created by jxm on 2017/6/28.
//  Copyright © 2017年 宓珂璟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSheetCustomPicker.h"
#import "MJExtension.h"

typedef void(^MyBlock)(NSString *address,NSArray *selections);
@interface CityChooseViewCreater : NSObject <ActionSheetCustomPickerDelegate>
@property (nonatomic,strong) NSArray *addressArr; // 解析出来的最外层数组
@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,strong) ActionSheetCustomPicker *picker; // 选择器

-(void)show:(UIView*)view;
@property (nonatomic,copy) MyBlock myBlock; //!< 回调地址的block
@end
