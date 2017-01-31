//
//  AppDelegate.m
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // JJB: Removed the ViewController and Main and now hand creating my own window.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [[LoginViewController alloc] init];
    
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Handle the OAuth callback from Twitter!  See rest of config in project settings info for URL
- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Success - got the access token");
        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
        
        // Verify the user - who it is BTW?
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"Progress is: %@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"Successful verify_creds: User: %@", responseObject);
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog (@"User created with name: %@ screenName:%@ and tagline:%@", user.name, user.screenname, user.tagline);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Failed to verify_creds for unknown user.");
        }];
        
        [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"Successful getting Tweets (via home_timeline): %@", responseObject);
            
            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
            for (Tweet *tweet in tweets) {
                NSLog(@" Tweet createdAt: %@ text: %@", tweet.createdAt, tweet.text);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog (@"Error getting tweets");
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failure to get the access token");
    }];
    return YES;

}

@end
