//
//  CMDAC_ServerGetAllDrugTimerResult.h
//  Protocol
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 fortune. All rights reserved.
//

#import "ServerCommand.h"
#import "DrugTimeScheme.h"
@interface CMDAC_ServerGetAllDrugTimeSchemeResult : ServerCommand

@property(nonatomic,strong) NSArray<DrugTimeScheme *> *schemeList;
-(id)initWithSchemeList:(NSArray*)schemelist;
@end
