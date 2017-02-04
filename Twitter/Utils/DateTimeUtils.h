//
//  DateTimeUtils.h
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTimeUtils : NSObject

+ (NSString *) nowPrettyPrint;
+ (NSString *) prettyPrint:(NSDate *)inputDateTime;
+ (NSString *) simpleCreateTimeString:(NSDate *)inputDateTime;

@end
