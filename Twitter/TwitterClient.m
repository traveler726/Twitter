//
//  TwitterClient.m
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "TwitterClient.h"
#import "JsonUtil.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"vPRomvts63A9GReL4BtzolwHh";
NSString * const kTwitterConsumerSecret = @"SudLbaZ75fjhqSWY2c1pbQzR9teuyboxJagPLyeE1LHiAHpR4q";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

// Property storying a function!
@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@property (nonatomic, strong) void (^userCompletion)(User *user, NSError *error);

@end

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

- (void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion {
    
    User *user = [User currentUser];
    if (user != nil) {
        NSLog(@"Starting up the login process - but already have a user: %@", user.name);
        completion(user, nil);
    } else {
        self.loginCompletion = completion;
        
        [self.requestSerializer removeAccessToken];
        [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo:/oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
            NSLog(@"Success - got the request token!");
            NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token ]];
            
            [[UIApplication sharedApplication] openURL:authURL options:@{} completionHandler:^(BOOL success) {
                NSLog(@"Open: %d",success);
            }];
            
            self.loginCompletion(user, nil);
            
        } failure:^(NSError *error) {
            NSLog(@"Failed to get the request token!");
            // Just call the completion and let it handle the error
            self.loginCompletion(nil, error);
        }];
        
    }
}
- (void) logoutWithCompletion:(void (^)(User *user, NSError *error)) completion {
    User *user = [User currentUser];
    if (user == nil) {
        NSLog(@"WARNING: Attempting to logout - but already logged out.");
        completion(user, nil);
    } else {
        [user logout];
        completion(nil, nil);
    }
}

// ------------------------------------------
// TODO - should verify
//    * url is expected URL before handling it.
//    * loginCompletion
// ------------------------------------------
- (void) openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Success - got the access token");
        [self.requestSerializer saveAccessToken:accessToken];
        
        // Verify the user - who it is BTW?
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"Progress is: %@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"Successful verify_creds: User: %@", responseObject);
            NSLog(@"Successful verify_creds: User: %@", responseObject[@"name"]);
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog (@"User created with name: %@ screenName:%@ and tagline:%@", user.name, user.screenname, user.tagline);
            
            [JsonUtil jsonStringFromDictionary:responseObject logToConsole:YES logPrefix:@"\n\n\nJSON FOR VERIFY_CREDS\n\n\n"];
            
            [User setCurrentUser:user];
            
            // Call the completion block stored away in 1st step with user!
            self.loginCompletion(user, nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Failed to verify_creds for unknown user.");
            
            // Call the completion block stored away in 1st step and let it handle the error
            self.loginCompletion(nil, error);

        }];
        
//      Proving all is working just fine with this call.  But not needed here.
//        [self GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"Successful getting Tweets (via home_timeline): %@", responseObject);
//            
//            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
//            for (Tweet *tweet in tweets) {
//                NSLog(@" Tweet createdAt: %@ text: %@", tweet.createdAt, tweet.text);
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog (@"Error getting tweets");
//        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Failure to get the access token");
    }];
}
// TODO - this should manage the threads better!
- (NSArray<Tweet *> *) getTweets {
    
    NSArray<Tweet *> *tweets = nil;
    
    // ToDo move all access to Twitter via the Client.
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"Successful getting Tweets (via home_timeline): %@", responseObject);
        
        [tweets arrayByAddingObjectsFromArray:[Tweet tweetsWithArray:responseObject]];
        for (Tweet *tweet in tweets) {
            NSLog(@" Tweet createdAt: %@ text: %@", tweet.createdAt, tweet.text);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog (@"Error getting tweets");
    }];
    
    return tweets;
}

- (void) getUser:(NSString *) screenname withCompletion:(void (^)(User *user, NSError *error))completion {
    
    self.userCompletion = completion;
    
    // TODO should be breaking the parameters out@
    NSString *urlPath = [NSString stringWithFormat:@"1.1/users/show.json?screen_name=%@", screenname];
    [self GET:urlPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [JsonUtil jsonStringFromDictionary:responseObject logToConsole:YES logPrefix:@"\n\n\nJSON for USER\n\n\n"];

        User *user = [[User alloc] initWithDictionary:responseObject];
        NSLog (@"User created with name: %@ screenName:%@ and tagline:%@", user.name, user.screenname, user.tagline);
        
        self.userCompletion(user, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.userCompletion(nil, error);
    }];

}

@end
