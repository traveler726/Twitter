//
//  TweetDetailViewController.m
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView
#import "TweetDetailViewController.h"
#import "UIUtils.h"
#import "DateTimeUtils.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *retweetedTopIcon;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetedByLabel;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesCountLabel;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self reloadData];
    
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"]     forState:UIControlStateSelected];
    [self.retweetButton  setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadData {
    NSLog(@"Will be reloading the data for the Tweet Detailed View");
    
    if (self.tweet != nil) {
        self.nameLabel.text = self.tweet.user.name;
        self.handleLabel.text = self.tweet.user.handle;
        self.timeStampLabel.text = [DateTimeUtils simpleCreateTimeString:self.tweet.createdAt];
        self.contentLabel.text = self.tweet.text;
        [self.profileImageView setImageWithURL:self.tweet.user.profileImageUrl];
        
        self.retweetsCountLabel.text  = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
        self.favoritesCountLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favoriteCount];

        
        if (self.tweet.retweetUser != nil) {
            self.retweetedByLabel.text = self.tweet.retweetUser.name;
            self.retweetedByLabel.hidden = NO;
            self.retweetedTopIcon.hidden = NO;
            self.retweetedLabel.hidden = NO;
            //self.retweetContainerHeightContraint.constant = 22;
        } else {
            self.retweetedByLabel.text = nil; // probably not needed but ???
            self.retweetedByLabel.hidden = YES;
            self.retweetedTopIcon.hidden = YES;
            self.retweetedLabel.hidden = YES;
            //self.retweetContainerHeightContraint.constant = 0;
        }
        
        if (self.tweet.favorited) {
            self.favoriteButton.selected = YES;
        }
        
        if (self.tweet.retweeted) {
            self.retweetButton.selected = YES;
        }
        
        if (self.tweet.replied) {
            self.replyButton.selected = YES;
        }
        // [self setNeedsUpdateConstraints];
    } else {
        
        self.nameLabel.text = nil;
        self.handleLabel.text = nil;
        self.timeStampLabel.text = nil;
        self.contentLabel.text = nil;
        self.profileImageView.image = nil;
        
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) setupNavBar {
    // Setup NavBar items now.  [Another reason should have custom TabBar Class.]
    UIBarButtonItem *replyButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Reply"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(onReplyNavButton:)];
    self.navigationItem.rightBarButtonItem = replyButton;
}

- (IBAction) onReplyNavButton :(id)sender {
    NSString *msgText = [NSString stringWithFormat:@"User selected reply for tweet: %@", self.tweet.text];
    [UIUtils messageToUser:msgText forNavController:self.navigationController];
}

- (IBAction)onReplyButton:(UIButton *)sender {
    NSString *msgText = [NSString stringWithFormat:@"User selected reply for tweet: %@", self.tweet.text];
    [UIUtils messageToUser:msgText forNavController:self.navigationController];
}

- (IBAction)onRetweetButton:(UIButton *)sender {
    NSString *msgText = [NSString stringWithFormat:@"User selected Retweet for tweet: %@", self.tweet.text];
    [UIUtils messageToUser:msgText forNavController:self.navigationController];
}
- (IBAction)onFavoriteButton:(UIButton *)sender {
    NSString *msgText = [NSString stringWithFormat:@"User selected Favorite for tweet: %@", self.tweet.text];
    [UIUtils messageToUser:msgText forNavController:self.navigationController];
}
@end
