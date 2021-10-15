//
//  iOSFrameworkTests04.m
//  iOSFrameworkTests
//
//  Created by suntongmian on 2021/10/13.
//

#import <XCTest/XCTest.h>
//#import <iOSFramework/iOSFramework.h>
#import "STMLogger.h"

@interface iOSFrameworkTests04 : XCTestCase
{
    STMLogger * _logger;
}

@end

@implementation iOSFrameworkTests04

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
    [_logger useMetal];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
