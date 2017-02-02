//
//  AppNavigationalManager.m
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//
#import "AppNavigationalManager.h"
#import "LoginViewController.h"
#import "TweetListViewController.h"
#import "UserProfileViewController.h"
#import "User.h"


// -------------------------------------------------------------
//
// Purpose: Manage at least the top two ViewControllers by
//          'hasA' UINavigationalController and providing
//          project level access to actions used to transition.
// -------------------------------------------------------------

@interface AppNavigationalManager ()

@property (nonatomic, strong) UINavigationController *managedNavController;

@property (nonatomic, strong) UIViewController   *loggedOutVC;
@property (nonatomic, strong) UITabBarController *loggedInTabBarVC;  // refactoring needed - move to own class.

@property (nonatomic, strong) LoginViewController *loginVC;

// TODO refactoring into more management classes for these.
@property (nonatomic, strong) User *activeUser;

@property (nonatomic, strong) TweetListViewController   *timeLineVC;
@property (nonatomic, strong) UINavigationController    *timeLineNavC;

@property (nonatomic, strong) UserProfileViewController *userProfileVC;
@property (nonatomic, strong) UINavigationController    *userProfileNavC;


@end

@implementation AppNavigationalManager

+ (instancetype) sharedObj {

    static AppNavigationalManager * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[AppNavigationalManager alloc] init];
        }
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        UIViewController *initialRootVC;
        // if ([self isUserLoggedIn]) {
        if (false) {
            NSLog(@"\n\nAppNavigationalManager determined user '%@' is currently logged in.", self.activeUser.name);
            initialRootVC = [self loggedInVC];
        } else {
            NSLog(@"\n\nAppNavigationalManager determined user NOT currently logged in.");
            initialRootVC = [self loggedOutVC];
        }
        self.managedNavController = [[UINavigationController alloc] initWithRootViewController:initialRootVC];
        self.managedNavController.navigationBarHidden = YES;
    };
    return self;
}

- (UIViewController *) rootVC {
    return self.managedNavController;
}


// ------------------------------------------------------------
// NOTE: TBD - some of this logic does not belong in this class
//       and needs to be refactored out.
// ------------------------------------------------------------
#pragma mark Management of Login/Logout logic and state.

- (BOOL) isUserLoggedIn {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        User *user = [User currentUser];
        self.activeUser = user;
    });
    return ((self.activeUser == nil) ? NO : YES);
}

- (UIViewController *) loggedInVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.loggedInTabBarVC == nil) {
            [self setupNewLoggedInTabBarVC];
        }
    });
    return self.loggedInTabBarVC;
}

- (UIViewController *) loggedOutVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.loginVC == nil) {
            [self setupNewLoginInVC];
        }
    });
    return self.loginVC;
}

- (void) userHasLoggedIn {
    // tell the managed NavigationController to change presentation
    // to the logged in VC since user is now logged in.
    
    // TODO - figure out how to not use a stack since not needed.
    UIViewController *vcToSwitchTo = [self loggedInVC];
    NSArray *navVCStack = [NSArray arrayWithObjects:vcToSwitchTo, nil];
    [self.managedNavController setViewControllers:navVCStack animated:YES];
}

- (void) userHasLoggedOut {
    // tell the managed NavigationController to change presentation
    // to the logged in VC since user is now logged in.
    
    // TODO - figure out how to not use a stack since not needed.
    UIViewController *vcToSwitchTo = [self loggedOutVC];
    NSArray *navVCStack = [NSArray arrayWithObjects:vcToSwitchTo, nil];
    [self.managedNavController setViewControllers:navVCStack animated:YES];
}


// ------------------------------------------------------------
// NOTE: TBD - refactoring opportunity here!
// ------------------------------------------------------------
#pragma mark Creation of the ViewControllers that AppNavigationController manages

// NOTE: making atomic even tho only called within automic currently just in case!
- (void) setupNewLoginInVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.loginVC == nil) {
            self.loginVC = [[LoginViewController alloc] init];
            if (self.loginVC == nil) {
                NSLog (@"Had problems creating the Login VC = LoginViewController!");
            }
        }
    });
}

- (void) setupNewLoggedInTabBarVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupTimeLineControl];
        [self setupUserProfileControl];
        
        // Setup the items for the tabbar - TBD should I do this below and can I reuse if I do?
        UITabBarItem *timeLineTabItem = [[UITabBarItem alloc] initWithTitle:self.timeLineVC.title image:nil tag:0];
        self.timeLineVC.tabBarItem = timeLineTabItem;
        
        UITabBarItem *userProfileTabItem = [[UITabBarItem alloc] initWithTitle:self.userProfileVC.title image:nil tag:0];
        self.userProfileVC.tabBarItem = userProfileTabItem;
        
        // Create the TabBarController now.
        UITabBarController *tabBarC = [[UITabBarController alloc] init];
        tabBarC.viewControllers = @[self.timeLineNavC, self.userProfileNavC];
        
        self.loggedInTabBarVC = tabBarC;
        
    });
}


// ------------------------------------------------------------
// NOTE: TBD - some of this logic does not belong in this class
//       and needs to be refactored out.
// ------------------------------------------------------------
#pragma mark Management of UITabBarController

- (void) setupTimeLineControl {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((self.timeLineVC == nil) || (self.timeLineNavC == nil)) {
            // Create the TweetTableView - used for User Home timeLine view.
            self.timeLineVC = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
            if (self.timeLineVC == nil) {
                NSLog (@"ERROR: Problems creating the Home timeLine VC = TweetListViewController!");
            } else {
                self.timeLineVC.title = @"TimeLine";
                self.timeLineNavC = [[UINavigationController alloc] initWithRootViewController:self.timeLineVC];
                if (self.timeLineNavC == nil) {
                    NSLog (@"ERROR: Problems creating the Home Time Line NavigationController!");
                }
            }
        } else {
            NSLog (@"WARNING: Already Setup for Home Time Line - something went amiss!");
        }
    });
}

- (void) setupUserProfileControl {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((self.userProfileVC == nil) || (self.userProfileNavC == nil)) {
            self.userProfileVC = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
            if (self.userProfileVC == nil) {
                NSLog (@"ERROR: Problems creating the User Profile VC = UserProfileViewController!");
            } else {
                self.userProfileVC.title = @"Profile";
                self.userProfileNavC = [[UINavigationController alloc] initWithRootViewController:self.userProfileVC];
                if (self.userProfileNavC == nil) {
                    NSLog (@"ERROR: Problems creating the User Profile NavigationController!");
                }
            }
        } {
            NSLog (@"WARNING: Already Setup for User Profile - something went amiss!");
        }
    });
}

@end
