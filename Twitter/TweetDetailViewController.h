//
//  TweetDetailViewController.h
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;

- (void) reloadData;

@end
