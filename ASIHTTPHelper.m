//
//  ASIHTTPHelper.m
//  OYesS
//
//  Created by apple on 14-12-3.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import "ASIHTTPHelper.h"

@implementation ASIHTTPHelper

+(void)requestDataByGETFromURL:(NSString*)urls AndDelegate:(id)del{
    //下载图片
    NSURL *url = [NSURL URLWithString: urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:del];
    [request startAsynchronous];
}
@end
