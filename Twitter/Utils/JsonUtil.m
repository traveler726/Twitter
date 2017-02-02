//
//  JsonUtil.m
//  
//
//  Created by Jennifer Beck on 2/1/17.
//
//

#import "JsonUtil.h"

@implementation JsonUtil

+ (NSString *) jsonStringFromDictionary:(NSDictionary *)dictionary {
    return [JsonUtil jsonStringFromDictionary:dictionary logToConsole:NO logPrefix:nil];
}

+ (NSString *) jsonStringFromDictionary:(NSDictionary *)dictionary logToConsole:(BOOL)logToConsole logPrefix:(NSString *)logPrefix {
    NSString *jsonString;
    NSError  *error;
    NSData   *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];
    if (! jsonData) {
        if (logToConsole) {
            NSLog(@"%@: Got an error: %@", logPrefix, error);
        }
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (logToConsole) {
            NSLog (@"%@:\n%@", logPrefix, jsonString);
        }
    }
    
    return jsonString;
}

@end
