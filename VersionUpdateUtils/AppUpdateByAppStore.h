//
//  AppUtils.h
//  OYesS
//
//  Created by apple on 14-12-16.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

#define TEST_APP_ID @"866964994"

@interface AppUpdateByAppStore : NSObject<ASIHTTPRequestDelegate>
@property (nonatomic,strong) NSString *app_id;

-(void)checkAppVersionUpdate;
@end
