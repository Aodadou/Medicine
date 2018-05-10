//
//  JSONObject.h
//  NewProtocol
//
//  Created by chendy on 13-9-6.
//  Copyright (c) 2013 year chendy. All rights reserved.
//

#import <Foundation/Foundation.h>

/////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Property Protocols
/**
 * Protocol for defining properties in a JSON Model class that should not be considered at all
 * neither while importing nor when exporting JSON.
 *
 * @property (strong, nonatomic) NSString&lt;Ignore&gt;* propertyName;
 *
 */
@protocol Ignore
@end

/**
 * Protocol for defining optional properties in a JSON Model class. Use like below to define
 * model properties that are not required to have values in the JSON input:
 *
 * @property (strong, nonatomic) NSString&lt;Optional&gt;* propertyName;
 *
 */
@protocol Optional
@end

/**
 * Protocol for defining index properties in a JSON Model class. Use like below to define
 * model properties that are considered the Model's identifier (id).
 *
 * @property (strong, nonatomic) NSString&lt;Index&gt;* propertyName;
 *
 */
@protocol Index
@end

/**
 * Make all objects Optional compatible to avoid compiler warnings
 */
@interface NSObject(JSONObjectPropertyCompatibility)<Optional, Index, Ignore>
@end

/**
 * ConvertOnDemand enables lazy model initialization for NSArrays of models
 *
 * @property (strong, nonatomic) NSArray&lt;JSONModel, ConvertOnDemand&gt;* propertyName;
 */
@protocol ConvertOnDemand
@end

/**
 * Protocol for excluded this property to format JSON String
 */
@protocol expose

@end
/**
 * Protocol for NSNumber
 */
@protocol NSNumber

@end

@protocol deprecated
/**
 * Protocol for deprecated attribute
 */
@end

/**
 * Protocol for NSString
 */
@protocol NSString

@end

/**
 * Make all arrays ConvertOnDemand compatible to avoid compiler warnings
 */
@interface NSArray(JSONObjectPropertyCompatibility)<ConvertOnDemand>

@end

/**
 * Make all expose Object compatible to avoid compiler warnings
 */
@interface NSObject(JSONObject)<expose>
@end

/////////////////////////////////////////////////////////////////////////////////////////////

@interface JSONObject : NSObject

/** @name Comparing models */

/**
 * The name of the model's property, which is considered the model's unique identifier.
 * You can define Index property by using the Index protocol:
 * @property (strong, nonatomic) NSString&lt;Index&gt;* id;
 */
-(NSString*)indexPropertyName;

@end
