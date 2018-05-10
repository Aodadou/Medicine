//
//  MyCalendar.h
//  Milk
//
//  Created by ytz on 15/1/10.
//  Copyright (c) 2015年 ytz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "DSLCalendarView.h"
@interface MyCalendar : UIView{
    UIView* superView;
    int offset;
}

@property (weak, nonatomic) IBOutlet DSLCalendarView *dsCalendar;


- (void)show;
- (void)disMiss;
@end
