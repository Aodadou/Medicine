//
//  BirthView.h
//  DianziCheng
//
//  Created by ytz on 14-7-2.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BirthView;
@protocol BirthViewDelegate <NSObject>
-(void)closeBirthView:(BirthView*)bview;

@end

@interface BirthView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(strong,nonatomic) id<BirthViewDelegate> delegate;
@property(nonatomic,assign) NSInteger type;
- (void)disMiss ;

- (IBAction)ActionClose:(UIButton *)sender;

- (void)show:(NSString*)value Type:(NSInteger)type MinDate:(NSDate*)minDate MaxDate:(NSDate*)maxDate;

@end
