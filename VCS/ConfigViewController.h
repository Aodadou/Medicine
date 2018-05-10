//
//  ConfigViewController.h
//  MedicineBox
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 jxm. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SmartConfig1.h"

@interface ConfigViewController : UIViewController<UITextFieldDelegate,SmartConfigDelegate,UIAlertViewDelegate,NSURLConnectionDataDelegate>

//@property(strong,nonatomic) NSString *groupId;
//@property(strong,nonatomic) NSString *placeName;
//@property(strong,nonatomic) NSString *scanValue;
//@property(assign,nonatomic) BOOL isAirControl;
//@property(strong,nonatomic) NSString *deviceName;

@property(weak,nonatomic) UIView* mMain;
@property (weak, nonatomic) IBOutlet UITextField *tf_ssid;
@property (weak, nonatomic) IBOutlet UITextField *tf_routerPwd;
- (IBAction)showPassword:(id)sender;
- (IBAction)config:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_config;


@property (weak, nonatomic) IBOutlet UIButton *btn_showPwd;
@property (weak, nonatomic) IBOutlet UIImageView *fastLight;
@property (weak, nonatomic) IBOutlet UIImageView *wifiImage;
//@property (weak, nonatomic) IBOutlet UILabel *lb_roomName;
//- (IBAction)act_selectRoom:(id)sender;

//@property (weak, nonatomic) IBOutlet UIImageView *img_roomBack;

@property (strong, nonatomic) UIButton *btn_cancelConfig;

@end
