//
//  DateTimeView.h
//  Milk
//
//  Created by ytz on 15/5/7.
//  Copyright (c) 2015年 ytz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DateTimeView;
@protocol DateTimeViewDelegate <NSObject>
//@optional
-(void)dateTimeView:(DateTimeView*)superView;

@end

@interface DateTimeView : UIView<UIPickerViewDelegate,UIPickerViewDataSource> {
    NSMutableArray *left;
    NSMutableArray *right;
    
    UIView* superView;
    int offset;
}
@property (weak, nonatomic) IBOutlet UILabel *lbMin;
@property (weak, nonatomic) IBOutlet UILabel *lbHour;

@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *minutePicker;
@property (nonatomic,weak) id<DateTimeViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;


@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;
@property (nonatomic,assign)  NSInteger row;
- (void)viewDidLoadRow:(NSInteger)row ;
-(void)setHour:(NSInteger)hour Minute:(NSInteger)min;
- (void)setMyHour:(NSInteger)hour;
- (void)setMyMinute:(NSInteger)minute;
- (void)disMiss;
- (void)show;
@end
