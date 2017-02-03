//
//  User.h
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString     *name;
@property (nonatomic, strong) NSString     *screenname;
@property (nonatomic, strong) NSURL        *profileImageUrl;
@property (nonatomic, strong) NSString     *tagline;
@property (nonatomic, assign) BOOL          following;

@property (nonatomic, strong) NSString     *followersCount;
@property (nonatomic, strong) NSString     *followingCount;

@property (nonatomic, strong) NSString     *handle;

@property (nonatomic, strong) NSDictionary *dictionary;   // Keep to serialize for persistent storage.

-(id) initWithDictionary:(NSDictionary *)dictionary;
-(void) logout;

+ (User *) currentUser;
+ (void) setCurrentUser:(User *) user;

@end
