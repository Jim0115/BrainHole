//
//  EOCAutoDictionary.h
//  HelloWorldInOC
//
//  Created by 王仕杰 on 6/15/16.
//  Copyright © 2016 王仕杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCAutoDictionary : NSObject

@property (nonatomic, copy) NSString* string;
@property (nonatomic) NSNumber* number;
@property (nonatomic) NSDate* date;
@property (nonatomic) id opaqueObject;

@end
