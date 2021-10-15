//
//  STMLogger.h
//  iOSFramework
//
//  Created by suntongmian on 2021/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STMLogger : NSObject

- (void)output;
- (void)output02;
- (void)readFileToOutput:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
