//
//  CMDA7_DeleteDrugTimer.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"

@interface CMDA7_DeleteDrugTimeScheme : ClientCommand
@property (nonatomic,strong) NSString* macId;
@property (nonatomic,strong) NSString* rfid;

-(id)initWithMacId:(NSString*)macId Rfid:(NSString*)rfid;
@end
