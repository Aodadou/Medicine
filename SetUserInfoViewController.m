//
//  SetViewController.m
//  Hygieia
//
//  Created by ytz on 14-6-6.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import "SetUserInfoViewController.h"
#import "SessionManger.h"
#import "MedicineBox-Swift.h"
#import "Util.h"
#import <Protocol/CMDHelper.h>
#import "GlobalMethod.h"
#import <Protocol/CMD03_ServerLoginRespond.h>
#import <Protocol/CMDAD_SetPationInfo.h>
#import <Protocol/CMDAE_ServerSetPationInfoResult.h>
#import "ImageUtils.h"
#import <Protocol/CMDB0_ServerReturnAllPationInfo.h>
#import "CityChooseViewCreater.h"

@interface SetUserInfoViewController()<BirthViewDelegate> {
    SessionManger *sm;
    CMDHelper *helper;
    PationInfo *user;
        NSUserDefaults *userDefault;
       UIImagePickerController *imagePicker;
    UIActionSheet *actionSheet;//照片还是照相的ACTIONSHEET

    UIAlertView *alertEdit;
    BirthView *dateView;
    CityChooseViewCreater *cityViewer;
    
    UIColor *disSelectColor;
    UIColor *selectColor;
}

@end

@implementation SetUserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    disSelectColor = [UIColor colorWithRed:166.0/255 green:180.0/255 blue:208.0/255 alpha:1.0];
    selectColor = [UIColor colorWithRed:100.0/255 green:147.0/255 blue:235.0/255 alpha:1.0];
    
	// Do any additional setup after loading the view.
    sm=[SessionManger shareSessionManger];
    helper=[CMDHelper shareInstance];
  
    userDefault = [NSUserDefaults standardUserDefaults];
   self.navigationController.interactivePopGestureRecognizer.enabled = true;
    [self initData];
    if (user) {
        [self refeshView];
    }
    _btnSave.hidden = NO;
    [ImageUtils setViewShapeCircle:_photo];
}


-(void)initData{
    user = [sm.pationInfos objectForKey:[sm getCurrentDevice].macId];
}

-(void)refreshPhoto{

    //从沙盒中通过Id取得图片
    UIImage *tempImage = [sm.pationImages objectForKey:sm.currentDid];
    if (tempImage) {
        [_photo setImage:tempImage];
//        [ImageUtils showPhotoWithImage:tempImage AndUIImageView:_photo];
    }else{
        _photo.image = [UIImage imageNamed:@"默认头像.png"];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self refeshView];
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCMD:) name:kReceiveCMD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPhoto) name:NOTIFY_REFRESH_UPHOTO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFF:) name:NOTIFY_REC_FF object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCMDLater:) name:NOTIFY_REC_CMD object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if (user) {
        [self refreshPhoto];
//    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)receiveCMDLater:(NSNotification*)obj{
     ServerCommand * cmd = [obj object];
    if (cmd->CommandNo ==[CMDAE_ServerSetPationInfoResult commandConst]) {
       
        [Util toast:@"保存成功" WithColor:[UIColor greenColor]];
//        [Util toast: ];
        [self initData];
        if (user) {
            [self refreshPhoto];
            [self refeshView];
        }
        _btnSave.hidden = true;
    }
    
    if (cmd->CommandNo == [CMDB0_ServerReturnAllPationInfo commandConst]) {
//        [self initData];
        if ( _btnSave.hidden) {
            [self initData];
            if (user) {
                [self refeshView];
            }
        }
        
     
    }
}

-(void)receiveCMD:(NSNotification*)obj {
    ServerCommand * cmd = [obj object];
    if (cmd->CommandNo == [CMD03_ServerLoginRespond commandConst]) {
        //在断线重连时用得上
        [GlobalMethod closePressDialog];
    }else if (cmd->CommandNo == [CMD11_ServerDelDeviceResult commandConst]) {
        CMD11_ServerDelDeviceResult *cmd11 = (CMD11_ServerDelDeviceResult*)cmd;
        if ([cmd11.device.id isEqualToString:[sm getCurrentDevice].macId]) {
            [self.navigationController popViewControllerAnimated:YES];
            [sm sendCmd:[[CMDA1_GetAllMedicineBox alloc]init]];
        }
    }
}
-(void)receiveFF:(NSNotification *)obj{
    
    [GlobalMethod closePressDialog];
    NSString * info = [obj.object objectForKey:@"info"];
    [GlobalMethod toast:info];
}


-(IBAction)btn_delete:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除设备？" message:@"删除之后将清除所有相关记录" preferredStyle:UIAlertControllerStyleAlert]           ;
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sm sendCmd:[[CMD10_DelDevice alloc] initWithDevid:[sm getCurrentDevice].macId]];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:true completion:nil];
}
- (IBAction)btn_back:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}

- (IBAction)btn_photo:(UIButton *)sender {
    actionSheet = [[UIActionSheet alloc]initWithTitle:@"获取头像方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)ActionEdit:(UIButton *)sender {
    int tag = (int)sender.tag;
    if (tag != 2) {
        cityViewer = [[CityChooseViewCreater alloc] init];
        cityViewer.myBlock = ^(NSString *address, NSArray *selections) {
//            NSLog(address,nil);
            [_btnLocation setTitle:address forState:UIControlStateNormal];
        };
        [cityViewer show:self.view];
        return;
    }
    [self showAlertEdit:(int)sender.tag];
    
}

- (IBAction)ActionSex:(UIButton *)sender {
    int tag = (int)sender.tag;
    _btnGirl.selected = tag == 4;
    _btnMan.selected = tag == 3;
    if (!_btnGirl.selected) {
        _lbFemale.textColor = disSelectColor;
    }else{
        _lbFemale.textColor = selectColor;
    }
    
    if (!_btnMan.selected){
        _lbMale.textColor = disSelectColor;
    }else{
        _lbMale.textColor = selectColor;
    }
    
    _btnSave.hidden = false;
}

- (IBAction)AciontUseRange:(UIButton *)sender {
    
    int tag = (int)sender.tag;
    if (tag == 7) {
        _btnOther.selected = !_btnOther.selected;
        if (!_btnOther.selected) {
            self.lbOther.textColor = disSelectColor;
        }else{
            self.lbOther.textColor = selectColor;
        }
    }else  if (tag == 8) {
        _btnTret.selected = !_btnTret.selected;
        if (!_btnTret.selected) {
            self.lbTret.textColor = disSelectColor;
        }else{
            self.lbTret.textColor = selectColor;
        }
    }else  if (tag == 9) {
        _btnHealth.selected = !_btnHealth.selected;
        if (!_btnHealth.selected) {
            self.lbHealth.textColor = disSelectColor;
        }else{
            self.lbHealth.textColor = selectColor;
        }
        
    }
     _btnSave.hidden = false;
}
- (IBAction)ActionBirth:(id)sender {
    if (dateView == nil) {
        dateView = [[[NSBundle mainBundle] loadNibNamed:@"BirthView" owner:self options:nil] objectAtIndex:0];
        dateView.delegate = self;
    }
    [dateView show:user.birthday Type:0 MinDate:nil MaxDate:[NSDate date]] ;
}

- (IBAction)ActionSave:(UIButton *)sender {
    NSString *name = _btnName.titleLabel.text;
    NSString *region = _btnLocation.titleLabel.text;
    int gender = _btnMan.selected?1:0;
    
    NSString *birthday = _btnBirth.titleLabel.text;
    NSString *purpose = [NSString stringWithFormat:@"%@:%@:%@",_btnHealth.selected?@"保健":@"",_btnTret.selected?@"治疗":@"",_btnOther.selected?@"其它":@""];
    
    if ([name containsString:@"设置"]) {
        [Util toast:@"未设置名字"];
        return;
    }
    if (region.length<=0) {
        [Util toast:@"未设置地区"];
        return;
    }
    if ([birthday containsString:@"设置"]) {
        [Util toast:@"未设置出生年月"];
        return;
    }
    if (!(_btnOther.selected||_btnHealth.selected||_btnTret.selected)) {
        [Util toast:@"未选择使用范围"];
        return;
    }
    if (user.avatarUrl == nil) {
        user.avatarUrl=@"";
    }
    PationInfo* newInfo = [[PationInfo alloc] initWithMacId:[sm getCurrentDevice].macId Name:name AvatarUrl:@"" Gender:gender Birthday:birthday Region:region Purpose:purpose];
    
    
    [sm sendCmd:[[CMDAD_SetPationInfo alloc] initWithPationInfo:newInfo]];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)showAlertEdit:(int)tag{
    NSString *title = tag == 2 ? @"编辑名字":@"编辑地区";
    NSString *hintText = tag == 2 ? @"请输入名字":@"请输入地区";
    NSString *text = tag == 2? user.name:user.region;
    if (alertEdit == nil) {
        alertEdit = [[UIAlertView alloc] init];
        alertEdit.delegate = self;
        [alertEdit addButtonWithTitle:@"取消"];
        [alertEdit addButtonWithTitle:@"确定"];
        [alertEdit setAlertViewStyle:UIAlertViewStylePlainTextInput];
    }
    alertEdit.title = title;
    [alertEdit textFieldAtIndex:0].placeholder = hintText;
    [alertEdit textFieldAtIndex:0].text = text;
    alertEdit.tag = tag;
    
    [alertEdit show];
}

-(void)closeBirthView:(BirthView *)bview{
    [_btnBirth setTitle:[Util dateFormatter:bview.datePicker.date] forState:UIControlStateNormal];
     _btnSave.hidden = false;
}
#pragma mark UIAlerViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        if (alertView.tag == kAlertAreaTag) {
            [_btnLocation setTitle:[alertView textFieldAtIndex:0].text forState:UIControlStateNormal];
            _btnSave.hidden = false;
        }else if (alertView.tag == kAlertNameTag){
             [_btnName setTitle:[alertView textFieldAtIndex:0].text forState:UIControlStateNormal];
         _btnSave.hidden = false;
        }
    }
}


-(void)refeshView{
    if (user.name==nil || user.name.length == 0) {
        [_btnName setTitle:@"未设置" forState:UIControlStateNormal];
    }else{
        [_btnName setTitle:user.name forState:UIControlStateNormal];
    }
    if (user.birthday==nil||user.birthday.length == 0) {
        [_btnBirth setTitle:@"未设置" forState:UIControlStateNormal];
    }else{
        [_btnBirth setTitle:user.birthday forState:UIControlStateNormal];
    }
    if (user.region==nil || user.region.length == 0) {
        [_btnLocation setTitle:@"未设置" forState:UIControlStateNormal];
    }else{
       [_btnLocation setTitle:user.region forState:UIControlStateNormal];
    }
    
    _btnMan.selected = user.gender == 1;
    _btnGirl.selected = user.gender == 0;
    if (!_btnGirl.selected) {
        _lbFemale.textColor = disSelectColor;
    }else{
        _lbFemale.textColor = selectColor;
    }
    
    if (!_btnMan.selected){
        _lbMale.textColor = disSelectColor;
    }else{
        _lbMale.textColor = selectColor;
    }
    
    
    if (user.purpose) {
        _btnTret.selected = [user.purpose containsString:@"治疗"];
        _btnHealth.selected = [user.purpose containsString:@"保健"];
        _btnOther.selected = [user.purpose containsString:@"其它"];
        
        if (!_btnOther.selected) {
            self.lbOther.textColor = disSelectColor;
        }else{
            self.lbOther.textColor = selectColor;
        }
        if (!_btnTret.selected) {
            self.lbTret.textColor = disSelectColor;
        }else{
            self.lbTret.textColor = selectColor;
        }
        if (!_btnHealth.selected) {
            self.lbHealth.textColor = disSelectColor;
        }else{
            self.lbHealth.textColor = selectColor;
        }

    }else{
        _btnTret.selected = false;
        _btnHealth.selected = false;
        _btnOther.selected = false;
        self.lbOther.textColor = disSelectColor;
        self.lbTret.textColor = disSelectColor;
        self.lbHealth.textColor = disSelectColor;
    }
}


#pragma mark -imagePickerController delegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //    [GlobalMethod saveImageToDocument:selectedImage imageName:@"tempUploadImg"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //将拍摄的图片保存
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    UIImage *edtiedImage = [ImageUtils imageWithImage:selectedImage scaledToSize:_photo.frame.size];
    [_photo setImage:edtiedImage];
    [sm.pationImages setObject:edtiedImage forKey:sm.currentDid];
//     [ImageUtils saveImageToDocument:edtiedImage imageName:sm.currentDid];
    [UtilSw saveImageToDocument:edtiedImage imageName:sm.currentDid];
    NSURL *uploadURL = [NSURL URLWithString:URL_UP_DPHOTO(sm.url_img, [ThreeDES encryptWithDefautKey:TOKEN_DEVICE(sm.userInfo.name, sm.password,sm.currentDid)])];
    ASIFormDataRequest *formDataRequest = [[ASIFormDataRequest alloc]initWithURL:uploadURL];
  
    //处理图片，使它不会太大
    NSData *data = UIImageJPEGRepresentation(selectedImage, 0.75);
    [formDataRequest setData:data withFileName:[NSString stringWithFormat:@"%@.png",sm.currentDid] andContentType:@"png" forKey:@"file"];
    formDataRequest.delegate = self;
    formDataRequest.uploadProgressDelegate = self;
    formDataRequest.showAccurateProgress = YES;
    [formDataRequest startAsynchronous];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
}
//-(void)requestFailed:(ASIHTTPRequest *)request{
//    NSLog(@"%@",request);
//}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    UIImage *image = [UIImage imageWithData:responseData];
    //如果是上传成功，则为nil
    if (image == nil&&request.responseStatusCode==200) {
        //下载图片
        NSURL *url = [NSURL URLWithString:URL_GET_DPHOTO( sm.url_img,[ThreeDES encryptWithDefautKey:TOKEN_DEVICE(sm.userInfo.name, sm.password,sm.currentDid)])];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    //不为nil则是下载图片
    else{
        NSDictionary *dic = [request responseHeaders];
        //取得服务器发来的对应的MAC
        NSString *username=[dic objectForKey:@"username"];
//        NSString *mac = [dic objectForKey:@"mac"];
        //取得服务器发来的版本号
        NSString *iconVer = [dic objectForKey:@"iconVer"];
        //得到最后的版本号
        if (nil==username) {
            NSLog(@"上传或下载失败！！%d",request.responseStatusCode);
            return;
        }
        NSNumber *lastVerNum = [userDefault objectForKey:username];
        int lastVerNumIntValue = [lastVerNum intValue];
        if (iconVer != nil) {
            //版本号变为现在的版本号
            lastVerNumIntValue = [iconVer intValue];
        }else{
            //版本号+1
            lastVerNumIntValue ++;
        }
        //重新保存
        [userDefault setObject:[NSNumber numberWithInt:lastVerNumIntValue] forKey:sm.currentDid];
         [UtilSw saveImageToDocument:image imageName:sm.currentDid];
        //[ImageUtils saveImageToDocument:image imageName:sm.currentDid];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:username];
//        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    }
    if (request.responseStatusCode == 200) {
        NSLog(@"上传或下载成功！%d",request.responseStatusCode);
    }else{
        NSLog(@"上传或下载失败！%d",request.responseStatusCode);
    }
}
#pragma mark -actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if (buttonIndex == 1){
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
         [self presentViewController:imagePicker animated:YES completion:nil];    }
}

@end
