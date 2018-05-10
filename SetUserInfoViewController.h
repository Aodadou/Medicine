//
//  SetViewController.h
//  Hygieia
//
//  Created by ytz on 14-6-6.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "MedicineBox-Swift.h"
#define kAlertNameTag 2
#define kAlertAreaTag 6
@interface SetUserInfoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *photo;


@property (strong, nonatomic) IBOutlet UIButton *btnName;

@property (weak, nonatomic) IBOutlet UIButton *btnBirth;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnGirl;
@property (weak, nonatomic) IBOutlet UIButton *btnMan;
@property (weak, nonatomic) IBOutlet UIButton *btnHealth;
@property (weak, nonatomic) IBOutlet UIButton *btnTret;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UILabel *lbHealth;
@property (weak, nonatomic) IBOutlet UILabel *lbTret;
@property (weak, nonatomic) IBOutlet UILabel *lbOther;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;



- (IBAction)btn_delete:(id)sender;
- (IBAction)btn_back:(id)sender;
- (IBAction)btn_photo:(UIButton *)sender;

- (IBAction)ActionEdit:(UIButton *)sender;
- (IBAction)ActionSex:(UIButton *)sender;

- (IBAction)AciontUseRange:(UIButton *)sender;
- (IBAction)ActionBirth:(id)sender;

@end
