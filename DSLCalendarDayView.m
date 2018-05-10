/*
 DSLCalendarDayView.h
 
 Copyright (c) 2012 Dative Studios. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "DSLCalendarDayView.h"
#import "NSDate+DSLCalendarView.h"


@interface DSLCalendarDayView () {
    BOOL hasTodayShow;
}

@end


@implementation DSLCalendarDayView {
    __strong NSCalendar *_calendar;
    __strong NSDate *_dayAsDate;
    __strong NSDateComponents *_day;
    __strong NSString *_labelText;
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor clearColor];
        _positionInWeek = DSLCalendarDayViewMidWeek;
    }
    
    return self;
}


#pragma mark Properties

- (void)setSelectionState:(DSLCalendarDayViewSelectionState)selectionState {
    _selectionState = selectionState;
    [self setNeedsDisplay];
}

- (void)setDay:(NSDateComponents *)day {
    _calendar = [day calendar];
    _dayAsDate = [day date];
    _day = nil;
    _labelText = [NSString stringWithFormat:@"%ld", (long)day.day];
    

}

- (NSDateComponents*)day {
    if (_day == nil) {
        _day = [_dayAsDate dslCalendarView_dayWithCalendar:_calendar];
    }
    
    return _day;
}

- (NSDate*)dayAsDate {
    return _dayAsDate;
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    [self setNeedsDisplay];
}


#pragma mark UIView methods

- (void)drawRect:(CGRect)rect {
    if ([self isMemberOfClass:[DSLCalendarDayView class]]) {
        // If this isn't a subclass of DSLCalendarDayView, use the default drawing
        [self drawBackground];
        [self drawBorders];
        [self drawDayNumber];
    }
}


#pragma mark Drawing

- (void)drawBackground {
    if (self.selectionState == DSLCalendarDayViewNotSelected) {
//        if (self.isInCurrentMonth) {
//            [[UIColor whiteColor] setFill];
//        }
//        else {
            [[UIColor whiteColor] setFill];
//        }
//        UIRectFill(self.bounds);
       
        UIRectFill(CGRectMake(self.bounds.origin.x+3, self.bounds.origin.y, self.bounds.size.width-5, self.bounds.size.height));
        if (!hasTodayShow) {
            NSDate *d = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:d];
            long year = [dateComponent year];
            long month = [dateComponent month];
            long da = [dateComponent day];
            if (_day == nil) {
                _day = [_dayAsDate dslCalendarView_dayWithCalendar:_calendar];
            }
            
            if (year == _day.year && month == _day.month && _day.day == da) {
                self.selectionState = DSLCalendarDayViewWholeSelection;
                [self drawDayNumber];
            }
            _day = nil;
            hasTodayShow = YES;
        }
      

    }
    else {
        switch (self.selectionState) {
            case DSLCalendarDayViewNotSelected:
//                 [[UIImage imageNamed:@"日历选中"]drawAtPoint:CGPointMake(7, 2)];
                break;
                
            case DSLCalendarDayViewStartOfSelection:
//                [[[UIImage imageNamed:@"日历选中"] resizableImageWithCapInsets:UIEdgeInsetsMake(24,24, 24, 24)] drawInRect:self.bounds];
                break;
                
            case DSLCalendarDayViewEndOfSelection:
//                [[[UIImage imageNamed:@"日历选中"] resizableImageWithCapInsets:UIEdgeInsetsMake(24,24, 24, 24)] drawInRect:self.bounds];
                break;
                
            case DSLCalendarDayViewWithinSelection:
//                 [[[UIImage imageNamed:@"日历选中"] resizableImageWithCapInsets:UIEdgeInsetsMake(24,24, 24, 24)] drawInRect:self.bounds];
                break;
                
            case DSLCalendarDayViewWholeSelection:
                //                 [[[UIImage imageNamed:@"角标"] resizableImageWithCapInsets:UIEdgeInsetsMake(24,24, 30, 30)] drawInRect:self.bounds];
                
                [[UIImage imageNamed:@"日历选中按钮"] drawAtPoint:CGPointMake(7, 2)];
                break;
        }
    }
}

- (void)drawBorders {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineWidth(context, 1.0);
//    
//    CGContextSaveGState(context);
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:255.0/255.0 alpha:1.0].CGColor);
//    CGContextMoveToPoint(context, 0.5, self.bounds.size.height - 0.5);
//    CGContextAddLineToPoint(context, 0.5, 0.5);
//    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, 0.5);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
//    
//    CGContextSaveGState(context);
//    if (self.isInCurrentMonth) {
//        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:205.0/255.0 alpha:1.0].CGColor);
//    }
//    else {
//        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:185.0/255.0 alpha:1.0].CGColor);
//    }
//    CGContextMoveToPoint(context, self.bounds.size.width - 0.5, 0.0);
//    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, self.bounds.size.height - 0.5);
//    CGContextAddLineToPoint(context, 0.0, self.bounds.size.height - 0.5);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
}

- (void)drawDayNumber {
    UIFont *textFont = [UIFont systemFontOfSize:17.0];
      CGSize textSize = [_labelText sizeWithFont:textFont];
       CGRect textRect = CGRectMake(ceilf(CGRectGetMidX(self.bounds) - (textSize.width / 2.0)), ceilf(CGRectGetMidY(self.bounds) - (textSize.height / 2.0)), textSize.width, textSize.height);
  
        if (self.isInCurrentMonth) {
         [[UIColor colorWithWhite:116.0/255.0 alpha:1.0] set];
            
    }
    else {
        [[UIColor colorWithWhite:216.0/255.0 alpha:1.0] set];
    }
    if (self.selectionState == DSLCalendarDayViewNotSelected) {
//        [[UIColor colorWithWhite:116.0/255.0 alpha:1.0] set];
    }
    else {
        [[UIColor whiteColor] set];
        [[UIImage imageNamed:@"日历选中按钮"]drawAtPoint:CGPointMake(7, 2)];
    }
    [_labelText drawInRect:textRect withFont:textFont];
}

@end
