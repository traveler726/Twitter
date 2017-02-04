//
//  UserProfileViewController.m
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "UserProfileViewController.h"
#import "TwitterClient.h"
#import "DateTimeUtils.h"
#import "UIUtils.h"
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView
#import "AppNavigationalManager.h"
#import "TweetCreateViewController.h"


@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;

// Also the buttons to change the data in the sub-content view
@property (weak, nonatomic) IBOutlet UIButton *tweetsButton;
@property (weak, nonatomic) IBOutlet UIButton *mediaButton;
@property (weak, nonatomic) IBOutlet UIButton *likesButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *subContentLabel;


@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    if (self.user != nil) {
        self.userScreenName = self.user.screenname;
    }
    [self loadUser];
}

// TODO - Put the loading of the data into the Data Model (i.e. User factory!)
-(void) loadUser:(NSString*)userScreenName {
    if (userScreenName != nil) {
            [[TwitterClient sharedInstance] getUser:userScreenName withCompletion:^(User *user, NSError *error) {
                self.user = user;
                self.userScreenName = userScreenName;
                NSLog(@"UserProfileViewController has refreshed the data for user: %@ screenname: %@ at %@", self.user.name, userScreenName, [DateTimeUtils nowPrettyPrint]);
                [self reloadData];
            }];
    } else {
        [self reloadData];
    }
}
-(void) loadUser {
    [self loadUser:self.userScreenName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadData {
    if (self.user == nil) {
        self.nameLabel.text = @"ERROR - Unknown User";
        self.handleLabel.text = nil;
        self.descriptionLabel.text = nil;
        self.followingCountLabel.text = nil;
        self.followerCountLabel.text = nil;
        self.subContentLabel.text = @"User Needed";
        self.profileImageView.hidden = YES;
    } else {
        self.nameLabel.text = self.user.name;
        self.handleLabel.text = self.user.handle;
        self.descriptionLabel.text = self.user.tagline;
        self.followingCountLabel.text = self.user.followingCount;
        self.followerCountLabel.text = self.user.followersCount;
        self.subContentLabel.text = @"Tweets Coming Soon";
        [self.profileImageView setImageWithURL:self.user.profileImageUrl];
        self.profileImageView.hidden = NO;
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
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Logout"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(onLogoutButton:)];
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Tweet"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(onCreateTweetButton:)];
    [tweetButton setImage:[UIImage imageNamed:@"edit-icon"]];
    self.navigationItem.leftBarButtonItem = logoutButton;
    self.navigationItem.rightBarButtonItem = tweetButton;

}


- (IBAction) onLogoutButton:(id)sender {
    [[AppNavigationalManager sharedObj] logCurrentUserOut];
    [UIUtils messageToUser:@"User has selected to Logout" forNavController:self.navigationController];
}

- (IBAction) onCreateTweetButton:(id)sender {    
    TweetCreateViewController *createVC = [[TweetCreateViewController alloc] initWithNibName:@"TweetCreateViewController" bundle:nil];
    [createVC loadUser:self.user];
    [self.navigationController pushViewController:createVC animated:YES];
}

- (IBAction)onTweetButton:(UIButton *)sender {
    NSString *alertMessage = @"Tweets Coming Soon";
    [UIUtils messageToUser:alertMessage forNavController:self.navigationController];
    self.subContentLabel.text = alertMessage;
}
- (IBAction)onMediaButton:(UIButton *)sender {
    NSString *alertMessage = @"Media Coming Soon";
    [UIUtils messageToUser:alertMessage forNavController:self.navigationController];
    self.subContentLabel.text = alertMessage;
}
- (IBAction)onLikesButton:(UIButton *)sender {
    NSString *alertMessage = @"Likes Coming Soon";
    [UIUtils messageToUser:alertMessage forNavController:self.navigationController];
    self.subContentLabel.text = alertMessage;}

@end
