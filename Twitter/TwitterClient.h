//
//  TwitterClient.h
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#include "User.h"

// #import <BDBOAuth1RequestOperationManager.h>

@interface TwitterClient : BDBOAuth1SessionManager // BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error)) compltion;
- (void) openURL:(NSURL *) url; 

@end
