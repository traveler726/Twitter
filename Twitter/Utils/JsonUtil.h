//
//  JsonUtil.h
//  
//
//  Created by Jennifer Beck on 2/1/17.
//
//

#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject

+ (NSString *) jsonStringFromDictionary:(NSDictionary *)dictionary;
+ (NSString *) jsonStringFromDictionary:(NSDictionary *)dictionary logToConsole:(BOOL)logToConsole logPrefix:(NSString *)logPrefix;

@end
