//
//  CMDA9_ModifyDrugTimer.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"
#import "DrugTimeScheme.h"
@interface CMDA9_ModifyDrugTimeScheme : ClientCommand
@property (nonatomic,strong) DrugTimeScheme* scheme;
-(id)initWithDrugTimeScheme:(DrugTimeScheme *)scheme;
@end
