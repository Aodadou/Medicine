//
//  CMD30_DelScene.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "ClientCommand.h"

///The client sends to delete a single profile
@interface CMD30_DelScene : ClientCommand<APPCommandProto>

///Profile ID
@property(nonatomic,strong) NSString<expose>* sceneid;

-(id)initWithSceneid:(NSString*)sceneid;

@end
