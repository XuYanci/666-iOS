//
//  NSMutableDictionary+SetObject.m
//
//  Created by Joey L. on 17/Jul/15.
//  Copyright (c) 2015 Joey L. All rights reserved.
//
//  https://github.com/buhikon/NSMutableDictionary-SetObject
//

#import "NSMutableDictionary+SetObject.h"

@implementation NSMutableDictionary (SetObject)

- (void)setObjectIfExists:(id)anObject forKey:(id<NSCopying>)aKey
{
    if(anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)setObjectAsIntegerNumberIfExists:(id)anObject forKey:(id<NSCopying>)aKey;
{
    if(anObject) {
        [self setObject:[NSNumber numberWithInteger:[anObject integerValue]] forKey:aKey];
    }
}

- (void)setObjectAsStringIfExists:(id)anObject forKey:(id<NSCopying>)aKey
{
    if(anObject) {
        [self setObject:[NSString stringWithFormat:@"%@", anObject] forKey:aKey];
    }
}

@end
