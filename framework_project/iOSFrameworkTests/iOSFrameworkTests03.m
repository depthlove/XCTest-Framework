//
//  iOSFrameworkTests03.m
//  iOSFrameworkTests
//
//  Created by suntongmian on 2021/10/13.
//

#import <XCTest/XCTest.h>
//#import <iOSFramework/iOSFramework.h>
#import "STMLogger.h"

@interface iOSFrameworkTests03 : XCTestCase
{
    STMLogger * _logger;
}

@end

@implementation iOSFrameworkTests03

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
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *filePath = @"";
    NSString *basePath = [bundle resourcePath];
    filePath = [basePath stringByAppendingString:@"/"];
    filePath = [filePath stringByAppendingString:@"test_data.txt"];
    
    [_logger readFileToOutput:filePath];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
