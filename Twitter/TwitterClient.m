//
//  TwitterClient.m
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"vPRomvts63A9GReL4BtzolwHh";
NSString * const kTwitterConsumerSecret = @"SudLbaZ75fjhqSWY2c1pbQzR9teuyboxJagPLyeE1LHiAHpR4q";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    
    // Make creation thread safe.
    // Leverage grand-central-dispatch so
    //  a) only run once
    //  b) block other threads once another thread had entered the code snippet.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc]
                          initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl]
                          consumerKey:kTwitterConsumerKey
                          consumerSecret:kTwitterConsumerSecret];
        }
    });

    return instance;
}


@end
