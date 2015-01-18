//
//  PlayWithArraysTests.m
//  PlayWithArraysTests
//
//  Created by Kate Polyakova on 1/18/15.
//  Copyright (c) 2015 Kate Polyakova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

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
    NSArray *borsh = @[@"Картошка", @"Лук", @"Морковка", @"Свекла", @"Капуста", @"Чеснок", @"Томат"];

    for(int i=borsh.count-1; i>=0; i--){
        NSString *string = borsh[(NSUInteger)i];
        NSLog(@"%@", string);
    }
    NSLog(@"\n");

    for (NSString * item in borsh.reverseObjectEnumerator){
        NSLog(@"%@", item);
    }

    [borsh.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", item);

        if (idx == 1) {
            *stop = YES;
        }
    }];

}

- (void)testExample03 {
    NSArray *borsh = @[@"Картошка", @"Лук", @"Морковка", @"Свекла", @"Капуста", @"Чеснок", @"Томат"];

    int i = [borsh indexOfObject: @"Лук"];
//    int i = [borsh indexOfObject: [NSString stringWithFormat:@"Лу", @"к"]];
    
    NSLog(@"Index of elements <Лук>: %d", i);
}

- (void)testExample04 {
    NSArray *borsh = @[@"Картошка",@"Перец", @"Лук", @"Морковка", @"Свекла", @"Капуста", @"Чеснок", @"Томат"];

    int i = [borsh indexOfObjectPassingTest:^BOOL(NSString *item , NSUInteger idx, BOOL *stop) {
        BOOL result = [item hasPrefix:@"М"];
        return result;
    }];
    NSLog(@"Индекс элемента, начинающегося на букву М: %d", i);
}

- (void)testExample05 {
    NSArray *borsh = @[@"Картошка", @"Томат",@"Перец", @"Лук", @"Морковка", @"Свекла", @"Капуста", @"Чеснок"];

    borsh = [borsh sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare: obj2];
    }];

//    borsh = [borsh sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
//
//        NSComparisonResult result = [obj1 compare: obj2];
//
//        if ([obj1 hasPrefix:@"Ч"]) {
//            result = NSOrderedAscending;
//        }
//        return result;
//    }];

    for (NSString * item in borsh){
        NSLog(@"%@", item);
    }

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
