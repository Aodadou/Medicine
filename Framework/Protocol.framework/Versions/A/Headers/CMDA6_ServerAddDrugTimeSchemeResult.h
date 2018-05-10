//
//  CMDA6_ServerAddDrugTimerResult.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "DrugTimeScheme.h"
@interface CMDA6_ServerAddDrugTimeSchemeResult : ServerCommand
@property (nonatomic,strong) DrugTimeScheme* scheme;
@end
