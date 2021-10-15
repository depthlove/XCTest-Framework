//
//  iOSFrameworkTests.m
//  iOSFrameworkTests
//
//  Created by suntongmian on 2021/10/13.
//

#import <XCTest/XCTest.h>
//#import <iOSFramework/iOSFramework.h>
#import "STMLogger.h"

@interface iOSFrameworkTests : XCTestCase
{
    STMLogger * _logger;
}

@end

@implementation iOSFrameworkTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _logger = [STMLogger new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [_logger output];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
