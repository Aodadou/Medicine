//
//  BirthView.m
//  DianziCheng
//
//  Created by ytz on 14-7-2.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import "BirthView.h"
#import "Util.h"
@implementation BirthView{
    UIView *superView;
    int tag;
}

- (void)show:(NSString*)value Type:(NSInteger)type MinDate:(NSDate*)minDate MaxDate:(NSDate *)maxDate{
    
    _type = type;
    if (value && value.length >= 10) {
        [_datePicker setDate:[Util dateFormatterByString:value]];//[Util dateFormatterByString:value Format:@"yyyy年MM月dd日"]];
    }else{
        [_datePicker setDate:[NSDate date]];
    }
    if (minDate!=nil) {
          [_datePicker setMinimumDate:minDate];
    }
    if (maxDate!=nil) {
        [_datePicker setMaximumDate:maxDate];
    }
  
    if (superView == nil) {
        superView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        superView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.frame = CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height);

        [superView addSubview:self];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:superView];
    }
}

- (IBAction)ActionClose:(UIButton *)sender {
    tag = (int)sender.tag;
    [self disMiss];
}

- (void)disMiss {
    if (tag > 0) {
        if ([self.delegate respondsToSelector:@selector(closeBirthView:)]) {
            [self.delegate closeBirthView:self];
        }
    }
   
    [self removeFromSuperview];
    [superView removeFromSuperview];
    superView = nil;
}

@end
