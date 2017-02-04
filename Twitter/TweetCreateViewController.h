//
//  TweetCreateViewController.h
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface TweetCreateViewController : UIViewController

- (void) reloadData;
- (void) loadUser:(User *) user;

@property (nonatomic, strong) User *user;

@end
