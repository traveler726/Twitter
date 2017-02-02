//
//  TweetTableViewCell.h
//  TwitterDemo
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHeightContraint;

@property (strong, nonatomic) Tweet* tweet;

- (void) reloadData;

@end
