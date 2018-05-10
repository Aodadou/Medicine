//
//  CMDA5_AddDrugTimer.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ClientCommand.h"
#import "DrugTimeScheme.h"
#import "SchemeTime.h"

@interface CMDA5_AddDrugTimeScheme : ClientCommand<APPCommandProto>

@property (nonatomic,strong) DrugTimeScheme* scheme;
-(id)initWithDrugTimeScheme:(DrugTimeScheme*)scheme;
@end
