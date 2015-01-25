//
//  PlayWithArraysTests.m
//  PlayWithArraysTests
//
//  Created by Kate Polyakova on 1/18/15.
//  Copyright (c) 2015 Kate Polyakova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+Testutils.h"

@interface PlayWithArraysTests : XCTestCase

@end

@implementation PlayWithArraysTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample01 {

    NSArray *borsh = @[@"Картошка", @"Лук", @"Морковка", @"Свекла", @"Капуста", @"Чеснок", @"Томат"];
    NSArray *borsh1 = [NSArray arrayWithObjects: @"Картошка", @"Лук", @"Морковка", @"Свекла", @"Капуста", @"Чеснок", @"Томат", nil];
    NSArray *borsh2 = [NSArray arrayWithArray:borsh];

    //enumeration in "for" loop
    for(NSUInteger i=0; i<borsh.count; i++){
        NSString *string = borsh[i];
        NSLog(@"%@", string);
    }
    NSLog(@"\n");

    //fast enumeration
    for (NSString * item in borsh){
        NSLog(@"%@", item);
    }
    NSLog(@"\n");

    //enumeration with block
    [borsh enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", item);

        if(idx==2){
            *stop = YES;
        }
    }];

}

- (void)testExample02 {
    NSArray *borsh = [self getTestData];

    for(int i=borsh.count-1; i>=0; i--){
        NSString *string = borsh[(NSUInteger)i];
        NSLog(@"%@", string);
    }
    NSLog(@"\n");

    for (NSString * item in borsh.reverseObjectEnumerator){
        NSLog(@"%@", item);
    }
    NSLog(@"\n");

    [borsh.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", item);

        if (idx == 2) {
            *stop = YES;
        }
    }];

}

- (NSArray *)getTestData {
    return [NSArray loadTestListByName:@"Vegetables" clazz:[PlayWithArraysTests class]];
}

- (void)testExample03 {
     NSArray *borsh = [self getTestData];

    int i = [borsh indexOfObject: @"Лук"];
//    int i = [borsh indexOfObject: [NSString stringWithFormat:@"Лу", @"к"]];
    
    NSLog(@"Index of elements <Лук>: %d", i);
}

- (void)testExample04 {
    NSArray *borsh = [self getTestData];

    int i = [borsh indexOfObjectPassingTest:^BOOL(NSString *item , NSUInteger idx, BOOL *stop) {
        BOOL result = [item hasPrefix:@"М"];
        return result;
    }];
    NSLog(@"Индекс элемента, начинающегося на букву М: %d", i);
}

- (void)testExample05 {
    NSArray *borsh = [self getTestData];

    NSString *firstPlacePrefix = @"Т";

    borsh = [borsh sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        if([obj1 hasPrefix:firstPlacePrefix] && [obj2 hasPrefix:firstPlacePrefix]){
            return [obj1 compare:obj2];
        } else if ([obj2 hasPrefix:firstPlacePrefix]){
            return NSOrderedDescending;
        } else if ([obj1 hasPrefix:firstPlacePrefix]){
            return NSOrderedAscending;
        } else {
            return [obj1 compare: obj2];
        }

    }];

//    borsh = [borsh sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
//        NSComparisonResult result = [obj1 compare: obj2];
//
//        if ([obj1 hasPrefix:@"Ч"]) {
//            result = NSOrderedAscending;
//        }
//        return result;
//    }];

    [borsh logArray];

//    for (NSString * item in borsh){
//        NSLog(@"%@", item);
//    }

}

- (void)testExample06 {
    NSArray *borsh = [self getTestData];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"Т"];
    NSArray *filtered = [borsh filteredArrayUsingPredicate:predicate];

    [filtered logArray];
}

- (void)testExamples07 {
    NSArray *borsh = [self getTestData];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString * evaluatedObject, NSDictionary *bindings) {

        NSRange range = [evaluatedObject rangeOfString:@"ка" options:NSCaseInsensitiveSearch];

        BOOL result = range.location != NSNotFound;

        return result;
    }];
    NSArray *filtered = [borsh filteredArrayUsingPredicate:predicate];

    [filtered logArray];
}

- (void)testExample08 {
    NSArray *borsh = [self getTestData];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString * evaluatedObject, NSDictionary *bindings) {
        BOOL result = evaluatedObject.length > 5;
        return result;
    }];
    NSArray *filtered = [borsh filteredArrayUsingPredicate:predicate];

    [filtered logArray];
}

- (void)testExample09 {
    NSArray *borsh = [self getTestData];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString * evaluatedObject, NSDictionary *bindings) {
        BOOL result = NO;
        if ([evaluatedObject hasPrefix:@"К"] && [evaluatedObject hasSuffix:@"а"]){
            result = YES;
        }
        return result;
    }];
    NSArray *filtered = [borsh filteredArrayUsingPredicate:predicate];

    [filtered logArray];
}

- (void)testExample10 {
    NSArray *borsh = [self getTestData];
    NSMutableArray *result = [NSMutableArray array];

    for(NSUInteger i=0; i<borsh.count; i++){
        NSString *string = borsh[i];
        NSString * replaced = [string stringByReplacingOccurrencesOfString:@"а" withString:@"о"];
        replaced = [replaced stringByReplacingOccurrencesOfString:@"А" withString:@"О"];
        replaced = [replaced stringByReplacingOccurrencesOfString:@"у" withString:@"ю"];
        replaced = [replaced stringByReplacingOccurrencesOfString:@"ы" withString:@"ю"];
        [result addObject:replaced];
    }

    [result logArray];
}

- (void)testExample11 {
    NSArray *borsh = [self getTestData];
    NSMutableArray *filteredArray = [NSMutableArray array];
    [borsh enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL *stop) {
        NSRange range = [item rangeOfString:@"ка" options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            [filteredArray addObject:item];
        }
    }];

    [filteredArray logArray];
}

- (void)testExample12 {
    NSArray *borsh = [self getTestData];
    NSMutableArray *filteredArray = [borsh mutableCopy];
    [borsh enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL *stop) {
        NSRange range = [item rangeOfString:@"ка" options:NSCaseInsensitiveSearch];
        if (range.location == NSNotFound) {
            [filteredArray removeObject:item];
        }
    }];

    [filteredArray logArray];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
