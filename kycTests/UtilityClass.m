//
//  UtilityClass.m
//  kyc
//
//  Created by Ilan Levy on 4/9/15.
//  Copyright (c) 2015 Ilan Levy. All rights reserved.
//

#import "UtilityClass.h"
#import <objc/message.h>

@implementation UtilityClass
+ (NSArray *) methodNamesForClass:(Class) aClass
{
    Method *methods;
    unsigned int methodCount;
    if ((methods = class_copyMethodList(aClass, &methodCount)))
    {
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:methodCount];
        while (methodCount--)
            [results addObject:[NSString stringWithCString: sel_getName(method_getName(methods[methodCount]))
                                                  encoding: NSASCIIStringEncoding]];
        free(methods);
        return results;
    }
    
    return nil;
}

@end
