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
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MMM d, h:mm a"];
//    NSString *nowString = [NSString stringWithFormat:@"@ %@",  [formatter stringFromDate:[NSDate date]]
//    NSString *nowPretty = [NSString stringWithFormat:@"@ %@...", [formatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm:ss a"];
    NSString *nowPretty = [NSString stringWithFormat:@"@ %@",[dateFormatter stringFromDate:[NSDate date]]];
    return nowPretty;
    
}

@end
