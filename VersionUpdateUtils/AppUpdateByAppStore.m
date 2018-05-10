//
//  AppUtils.m
//  OYesS
//
//  Created by apple on 14-12-16.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import "AppUpdateByAppStore.h"

#define URL_ITUNES(ID) [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",ID]

@implementation AppUpdateByAppStore{
    NSString *version;
    NSString *loadURL;
}
-(void)checkAppVersionUpdate{
    ASIFormDataRequest *versionRequest;
    version=@"";
    if (_app_id==nil) {
        return;
       
    }
    NSURL *url = [NSURL URLWithString:URL_ITUNES(_app_id)];
    versionRequest = [ASIFormDataRequest requestWithURL:url];
    [versionRequest setRequestMethod:@"GET"];
    [versionRequest setDelegate:self];
    [versionRequest setTimeOutSeconds:150];
    [versionRequest addRequestHeader:@"Content-Type" value:@"application/json"];
    [versionRequest startSynchronous];
}


-(void)requestFinished:(ASIHTTPRequest *)versionRequest{
    NSError *error=nil;
    @try {
        //Response string of our REST call
        //把 NSString -> NSDictionary
        NSString* jsonResponseString = [versionRequest responseString];
        NSData *jsonData=[jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *loginAuthenticationResponse =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        //从NSDictionary 中读取result的值
        NSArray *configData = [loginAuthenticationResponse valueForKey:@"results"];
        for (id config in configData)
        {
            version = [config valueForKey:@"version"];//版本信息
            loadURL=[config valueForKey:@"trackViewUrl"];//下载地址
        }
        
        //Check your version with the version in app store   ／／读取当前app的版本号 CFBundleShortVersionString
        if (![version isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]])
        {
            UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"New Version!!", nil)  message: NSLocalizedString(@"A new version of app is available to download", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles: NSLocalizedString(@"Download", nil), nil];
            [createUserResponseAlert show];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    if (versionRequest.responseStatusCode==200) {
        NSLog(@"获取appstore版本信息成功！",nil);
    }else{
        NSLog(@"获取appstore版本信息失败！ErrorCode:%i",versionRequest.responseStatusCode);
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"获取appstore版本信息失败！",nil);
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        //        NSString *iTunesLink = [NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=@%@&mt=8",_app_id];
        if (loadURL) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:loadURL]];
        }
    }
}

@end
