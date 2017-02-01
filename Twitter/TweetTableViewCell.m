//
//  TweetTableViewCell.m
//  TwitterDemo
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "TweetTableViewCell.h"

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



@end


@implementation TweetTableViewCell

// Called on the cell after all the views have been created on the cell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.namelabel.text = @"Jennifer Beck";
    self.handleLabel.text = @"jjbeck";
    self.timestampLabel.text = @"4h";
    self.contentLabel.text = [NSString stringWithFormat:@"%ld This is a simple tweet", self.rowCount];
    //self.contentLabel.text = @"This is a simple tweet.  But I want the text to be really really long.   I really am wondering how much text can actually fit into the cell.";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
