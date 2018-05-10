//
//  DateTimeView.m
//  Milk
//
//  Created by ytz on 15/5/7.
//  Copyright (c) 2015年 ytz. All rights reserved.
//

#import "DateTimeView.h"
#import "Util.h"
@implementation DateTimeView
- (void)viewDidLoadRow:(NSInteger)row {
    left = [[NSMutableArray alloc]init];
    right = [[NSMutableArray alloc]init];
    for (int i = 0; i < 60; i++) {
        if (i < 24) {
            [left addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [right addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _hourPicker.delegate = self;
    _hourPicker.dataSource = self;
    
    _minutePicker.delegate = self;
    _minutePicker.dataSource = self;
    self.row = row;
    
}
- (void)setMyHour:(NSInteger)hour {
    self.hour = hour;
    [_hourPicker selectRow:hour inComponent:0 animated:YES];
}
- (void)setMyMinute:(NSInteger)minute {
    self.minute = minute;
    [_minutePicker selectRow:minute inComponent:0 animated:YES];
}
-(void)setHour:(NSInteger)hour Minute:(NSInteger)min{
    self.minute = min;
    [_minutePicker selectRow:min inComponent:0 animated:YES];
    self.hour = hour;
    [_hourPicker selectRow:hour inComponent:0 animated:YES];
}
- (void)show {
    if (superView == nil) {
        superView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        superView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.frame = CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height);
        
        
        [superView addSubview:self];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:superView];
        
        CGRect temp = _lbMin.frame;
//        _lbMin.frame = CGRectMake(temp.origin.x, _hourPicker.frame.origin.y+_hourPicker.frame.size.height/2 - temp.size.height/2, temp.size.width, temp.size.height);
//        
//        _lbHour.frame = CGRectMake(_lbHour.frame.origin.x, _hourPicker.frame.origin.y + _hourPicker.frame.size.height/2 - temp.size.height/2, temp.size.width, temp.size.height);
        [self invalidateIntrinsicContentSize];
        
    }
}


- (IBAction)actionSure:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dateTimeView:)]) {
        [self.delegate dateTimeView:self];
    }
}
- (IBAction)actionCancel:(id)sender {
    [self disMiss];
}



- (void)disMiss {
//    NSLog(@"dismiss row:%d",_row);
  
    [self removeFromSuperview];
    [superView removeFromSuperview];
    superView = nil;
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
    
    

}
#pragma mark dataSouce
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView ==  _hourPicker) {
        return left.count;
    }else {
        return right.count;
    }
    
}
- (CGFloat) pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.0;
}
//- (CGFloat) pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component {
//    return self.frame.size.width/2;
//}
#pragma mark delegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
        if (pickerView == _hourPicker) {
           return [left objectAtIndex:row];
                   }else {
            
           return  [right objectAtIndex:row];
           
    
        }
}
//- (UIView*)pickerView:(UIPickerView*)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    UIView *myView = [[UIView alloc]init];
//    CGFloat width = [self pickerView:pickerView widthForComponent:component];
//    CGFloat height = [self pickerView:pickerView rowHeightForComponent:component];
//    
//    myView.frame = CGRectMake(0, 0, width, height);
//    
//    myView.backgroundColor = [UIColor clearColor];
//    UILabel *label  = [[UILabel alloc]init];
//    
//    if (pickerView == _hourPicker) {
//        label.frame = CGRectMake(0, 0, width-30, height);
//        [label setTextAlignment:NSTextAlignmentRight];
//        label.text = [left objectAtIndex:row];
//        if (_hour == row) {
//            label.textColor = UIColorFromRGB(0xed699d);
//
//        }else {
//            label.textColor = UIColorFromRGB(0x6a5e5e);
//        }
//        
//    }else {
//        [label setTextAlignment:NSTextAlignmentLeft];
//        label.frame = CGRectMake(30, 0, width-30, height);
//        label.text = [right objectAtIndex:row];
//        if (_minute == row) {
//            label.textColor = UIColorFromRGB(0xed699d);
//            
//        }else {
//            label.textColor = UIColorFromRGB(0x6a5e5e);
//        }
//
//    }
//   
//   
//    [label setFont:[UIFont systemFontOfSize:25]];
//    [myView addSubview:label];
//    return myView;
//    
//}
//-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return @"";
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _hourPicker){
        self.hour = row;
        [_hourPicker reloadAllComponents];
    }else  {
        self.minute = row;
        [_minutePicker reloadAllComponents];
    }
}


@end
