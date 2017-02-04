//
//  AppNavigationalManager.h
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface AppNavigationalManager : NSObject

// Singleton pattern - need way to get shared obj.
+ (instancetype) sharedObj;

- (UIViewController *) rootVC;

- (void) userHasLoggedIn;
- (void) userHasLoggedOut;

- (void) pushUserProfileView:(NSString *)screenname ontoNavWithName:(NSString*)navName;
- (void) pushTweetDetailView:(Tweet    *)tweet      ontoNavWithName:(NSString*)navName;


@end
