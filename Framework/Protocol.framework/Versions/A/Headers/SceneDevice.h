//
//  SceneDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import "JSONObject.h"

///Scene Device
@interface SceneDevice : JSONObject

///Scene ID(GUID)
@property(nonatomic,strong) NSString* sceneid;

///Enabled
@property(nonatomic,assign) BOOL enabled;

-(id)initWithSceneid:(NSString*)sceneid_ Enabled:(BOOL)enabled_;

@end
