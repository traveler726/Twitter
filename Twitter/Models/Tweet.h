//
//  Tweet.h
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;        // tweet text
@property (nonatomic, strong) NSDate   *createdAt;   // Creation time
@property (nonatomic, strong) User     *user;        // Author
@property (nonatomic, strong) User     *retweetUser; // User that retweeted

@property (nonatomic, assign) NSInteger favoriteCount;
@property (nonatomic, assign) NSInteger retweetCount;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, assign) BOOL replied; 

-(id) initWithDictionary:(NSDictionary *)dictionary;

- (NSString *) elapsedTimeSinceCreated;

+ (NSArray *) tweetsWithArray:(NSArray *)array;

@end
