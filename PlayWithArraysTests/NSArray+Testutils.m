//
// Created by Kate Polyakova on 1/25/15.
// Copyright (c) 2015 Kate Polyakova. All rights reserved.
//

#import "NSArray+Testutils.h"


@implementation NSArray (Testutils)

+ (NSArray *)loadTestListByName:(NSString *)listName clazz:(Class)clazz {
    NSBundle *bundle = [NSBundle bundleForClass:clazz];
    NSString *path = [bundle pathForResource:listName ofType:@"plist"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSArray *borsh = [NSArray arrayWithContentsOfURL:url];
    return borsh;
}

- (void)logArray {
    NSString *arrayAsString = [self componentsJoinedByString:@"\n"];
    NSLog(@"\nArray, count:%d \n[%@]\n", self.count, arrayAsString);
}

@end