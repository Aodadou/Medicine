//
//  CMDBC_QueryDrugInfoByBarCode.h
//  Protocol
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"

@interface CMDBC_QueryDrugInfoByBarCode : ClientCommand
@property(strong,nonatomic) NSString *barcode;
-(id)initWithBarcode:(NSString*)barcode;
@end
