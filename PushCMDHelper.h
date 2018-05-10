//
//  PushCMDHelper.h
//  MedicineBox
//
//  Created by 吴杰平 on 2017/7/5.
//  Copyright © 2017年 jxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Protocol/CMD73_SetParameter.h>
#define PUSHPORT 9012


@interface PushCMDHelper : NSObject

@property (nonatomic,strong) NSString *deviceToken;

- (void)sendCMD73;

@end
