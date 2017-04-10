//
//  NSMutableDictionary+SetObject.h
//
//  Created by Joey L. on 17/Jul/15.
//  Copyright (c) 2015 Joey L. All rights reserved.
//
//  https://github.com/buhikon/NSMutableDictionary-SetObject
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SetObject)
- (void)setObjectIfExists:(id)anObject forKey:(id<NSCopying>)aKey;
- (void)setObjectAsIntegerNumberIfExists:(id)anObject forKey:(id<NSCopying>)aKey;
- (void)setObjectAsStringIfExists:(id)anObject forKey:(id<NSCopying>)aKey;
@end
