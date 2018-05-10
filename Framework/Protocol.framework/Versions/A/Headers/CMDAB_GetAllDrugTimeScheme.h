//
//  CMDAB_GetAllDrugTimer.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"

@interface CMDAB_GetAllDrugTimeScheme : ClientCommand
@property(nonatomic,strong) NSString* macId;
-(id)initWithMacId:(NSString*)macId;
@end
