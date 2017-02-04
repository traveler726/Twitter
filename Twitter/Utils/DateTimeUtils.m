//
//  DateTimeUtils.m
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "DateTimeUtils.h"

@implementation DateTimeUtils

+(NSString *) nowPrettyPrint {
    // Setting up formatter can be done once and not each time!
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm:ss a"];
    NSString *nowPretty = [NSString stringWithFormat:@"@ %@",[dateFormatter stringFromDate:[NSDate date]]];
    return nowPretty;
    
}


+(NSString *) prettyPrint:(NSDate *)inputDateTime {
    // Setting up formatter can be done once and not each time!
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm:ss a"];
    NSString *nowPretty = [NSString stringWithFormat:@"@ %@",[dateFormatter stringFromDate:inputDateTime]];
    return nowPretty;
    
}


+ (NSString *) simpleCreateTimeString:(NSDate *)inputDateTime {
    NSString *timeStr = @"tbd";
    if (inputDateTime != nil) {
        
        // Setting up formatter can be done once and not each time!
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M-d-y, hh:mm a"];
        timeStr = [dateFormatter stringFromDate:inputDateTime];
    }
    return timeStr;
}


@end
