//
//  TweetTableViewCell.m
//  TwitterDemo
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView
#import "TweetTableViewCell.h"
#import "Tweet.h"


@interface TweetTableViewCell ()

// TBD Will need the label in the Top Container

// Image View in Image Container
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

// 4 labels in the Content Container
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

// 3 buttons in the Stack View at bottom
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

// top container for retweeted info
@property (weak, nonatomic) IBOutlet UILabel *retweetedbyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *retweetedTopIcon;

@end


@implementation TweetTableViewCell

// Called on the cell after all the views have been created on the cell
- (void)awakeFromNib {
    [super awakeFromNib];    
}

- (void) reloadData {
    
    if (self.tweet != nil) {
        self.namelabel.text = self.tweet.user.name;
        self.handleLabel.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenname];
        self.timestampLabel.text = [self.tweet elapsedTimeSinceCreated];
        self.contentLabel.text = self.tweet.text;
        [self.profileImageView setImageWithURL:self.tweet.user.profileImageUrl];
        
        if (self.tweet.retweetUser != nil) {
            self.retweetedbyLabel.text = self.tweet.retweetUser.name;
            self.retweetedbyLabel.hidden = NO;
            self.retweetedTopIcon.hidden = NO;
        } else {
            self.retweetedbyLabel.text = nil; // probably not needed but ???
            self.retweetedbyLabel.hidden = YES;
            self.retweetedTopIcon.hidden = YES;
        }
    } else {
        
        self.namelabel.text = nil;
        self.handleLabel.text = nil;
        self.timestampLabel.text = nil;
        self.contentLabel.text = nil;
        self.profileImageView.image = nil;

    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
