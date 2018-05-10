//
//  CMD38_DelSceneDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends to delete a single scene equipment
@interface CMD38_DelSceneDevice : ClientCommand<APPCommandProto>

///Scenario ID
@property(nonatomic,strong) NSString<expose>* sceneid;

///Device ID
@property(nonatomic,strong) NSString<expose>* devid;

-(id)initWithSceneid:(NSString*)sceneid Devid:(NSString*)devid;

@end
