//
//  ASIHTTPHelper.h
//  OYesS
//
//  Created by apple on 14-12-3.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface ASIHTTPHelper : NSObject
+(void)requestDataByGETFromURL:(NSString*)urls AndDelegate:(id)del;
@end
