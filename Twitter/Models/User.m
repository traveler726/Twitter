//
//  User.m
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "User.h"

static NSString *const CurrentUserPersistKey = @"kMyTwitterUserKey";
static User *myCurrentUser = nil;


@implementation User

-(id) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.tagline = dictionary[@"description"];
        self.following = [dictionary[@"following"] boolValue];
        self.dictionary = dictionary;
        
    }
    return self;
}


+ (User *) currentUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (myCurrentUser == nil) {
            User *user = [User inflateUser];
            if (user != nil) {
                NSLog(@"Inflated a user from disk - but is it usable without OAuth? name:%@", user.name);
            } else {
                NSLog(@"Tried to inflate a user from disk but it was nil");
            }
            myCurrentUser = user;
        }
    });
    return myCurrentUser;
}

+ (void) setCurrentUser:(User *) user {
    
    if (myCurrentUser != nil) {
        NSLog(@"Setting the current user to: %@ when there is already a current user: %@", myCurrentUser.name, user.name);
    }
    myCurrentUser = user;
    [User persistUser];
}

+ (void) persistUser {
    User *user = [User currentUser];
    if (user != nil) {
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:user.dictionary];
        if (data) {
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:CurrentUserPersistKey];
        } else { // need to "logout" by storing nil for entry.
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:CurrentUserPersistKey];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
}

+ (User *) inflateUser {
    User *user = myCurrentUser;
    if (user == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentUserPersistKey];
        if (data) {
            NSDictionary *userDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            user = [[User alloc] initWithDictionary:userDictionary];
        }
    }
    return user;
}


@end
