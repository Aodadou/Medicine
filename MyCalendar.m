//
//  MyCalendar.m
//  Milk
//
//  Created by ytz on 15/1/10.
//  Copyright (c) 2015年 ytz. All rights reserved.
//

#import "MyCalendar.h"

@implementation MyCalendar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)show {
    if (superView == nil) {
        superView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        superView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        CGRect frame = self.frame;
        frame.origin.x = superView.frame.size.width/2-frame.size.width/2;
        frame.origin.y = superView.frame.size.height/2 - frame.size.height/2;
        self.frame = frame;
        [superView addSubview:self];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:superView];
    }

}
- (void)disMiss {
    [self removeFromSuperview];
    [superView removeFromSuperview];
    superView = nil;
}
@end
