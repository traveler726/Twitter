//
//  Tweet.m
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

-(id) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        // Do stuff with the dictionary to init the tweet object.
        self.text = dictionary[@"text"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        
        // "created_at" = "Mon Jan 30 16:26:19 +0000 2017";
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE MMM d HH:mm:ss Z y"];
        self.createdAt = [dateFormatter dateFromString:createdAtString];
        //self.createdAt = [NSDate
    }
    return self;
}

+ (NSArray *) tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end
