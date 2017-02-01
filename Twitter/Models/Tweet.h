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

@property (nonatomic, strong) NSString * text;       // tweet text
@property (nonatomic, strong) NSDate   * createdAt;  // Creation time
@property (nonatomic, strong) User     * user;       // Author


-(id) initWithDictionary:(NSDictionary *)dictionary;

- (NSString *) elapsedTimeSinceCreated;

+ (NSArray *) tweetsWithArray:(NSArray *)array;

@end
