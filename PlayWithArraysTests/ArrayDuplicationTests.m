//
//  ArrayDuplicationTests.m
//  PlayWithArrays
//
//  Created by Kate Polyakova on 1/29/15.
//  Copyright (c) 2015 Kate Polyakova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+Testutils.h"

@interface ArrayDuplicationTests : XCTestCase

@end

@implementation ArrayDuplicationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSArray *)getTestData {
    return [NSArray loadTestListByName:@"Fruits" clazz:[ArrayDuplicationTests class]];
}

- (void)testArrayByRemovingDuplications {
    NSArray *testArray = @[@"abc", @"abi",@"abc",@"aba",@"abc",@"aba"];
    NSArray *resultArray  = [testArray arrayByRemovingDuplications];
    [resultArray logArray];
    XCTAssertEqual(resultArray.count, 3);
    XCTAssertNotEqual([resultArray indexOfObject:@"abi"], NSNotFound);
    XCTAssertNotEqual([resultArray indexOfObject:@"abc"], NSNotFound);
    XCTAssertNotEqual([resultArray indexOfObject:@"aba"], NSNotFound);
}

- (void)testCountOfObjectOccurrences{
    NSArray *simpleData = @[@"abc", @"abc",@"aba"];

    NSObject *object1 = @"abc";
    NSLog(@"\nString '%@' contains %d times", object1, [simpleData countOfObjectOccurrences:object1]);
    NSObject *object2 = @"cadabra";
    NSLog(@"\nString '%@' contains %d times", object2, [simpleData countOfObjectOccurrences:object2]);

    XCTAssertEqual([simpleData countOfObjectOccurrences:@"abc"], 2);
    XCTAssertEqual([simpleData countOfObjectOccurrences: @"cadabra"], 0);

}

- (void)testAmountOfDuplications {
    NSArray *kompot = [self getTestData];
    [kompot logArray];

    NSArray *filteredArray = [kompot arrayByRemovingDuplications];
    NSUInteger amount = 0;
    for(NSUInteger i=0; i<filteredArray.count; i++){
        amount = [kompot countOfObjectOccurrences:filteredArray[i]];
        NSLog(@"\n%@ - %d ", filteredArray[i], amount);
    }


}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
