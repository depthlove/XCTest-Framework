//
//  STMLogger.m
//  iOSFramework
//
//  Created by suntongmian on 2021/10/13.
//

#import "STMLogger.h"

@implementation STMLogger

- (void)output {
    for (int i = 0; i < 10; i++) {
        NSLog(@"%s, %d, i: %d", __func__, __LINE__, i);
    }
}

- (void)output02 {
    for (int i = 0; i < 20; i++) {
        NSLog(@"%s, %d, i: %d", __func__, __LINE__, i);
    }
}

- (void)readFileToOutput:(NSString *)filePath {
    NSLog(@"%s, %d, filePath: %@", __func__, __LINE__, filePath);
    
    NSError *error;
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%s, %d, error: %@", __func__, __LINE__, [error localizedDescription]);
    }
    NSLog(@"%s, %d, file content:\n%@", __func__, __LINE__, fileContent);
}

@end
