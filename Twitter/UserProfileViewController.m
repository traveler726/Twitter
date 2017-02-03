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
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView


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
    [self reloadData];

//    [self loadUser]
//    // Do any additional setup after loading the view from its nib.
//    if (self.user != nil) {
//        self.userScreenName = self.user.screenname;
//    }
//    if (self.userScreenName != nil) {
//        [self loadUser];
//    }
}

// TODO - have a timing issue here - so going to just punt for now and add the crazy thread blocker!
-(void) loadUser:(NSString*)userScreenName {
    if (userScreenName != nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[TwitterClient sharedInstance] getUser:userScreenName withCompletion:^(User *user, NSError *error) {
                self.user = user;
                self.userScreenName = userScreenName;
                NSLog(@"UserProfileViewController has refreshed the data for user: %@ screenname: %@ at %@", self.user.name, userScreenName, [DateTimeUtils nowPrettyPrint]);
                [self reloadData];
            }];
        });
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
                                     action:@selector(logoutButtonSelected:)];
    self.navigationItem.rightBarButtonItem = logoutButton;
}


- (IBAction) logoutButtonSelected :(id)sender {
    NSLog(@"User has selected to Logout");
}
- (IBAction)onTweetButton:(UIButton *)sender {
    [self messageToUser:@"Tweets Coming Soon"];
}
- (IBAction)onMediaButton:(UIButton *)sender {
    [self messageToUser:@"Media Coming Soon"];

}
- (IBAction)onLikesButton:(UIButton *)sender {
    [self messageToUser:@"Likes Coming Soon"];
}

-(void) messageToUser:(NSString *) message {
    // Easy way deprecated:
    // [self presentViewController(alertController, animated: true, completion: nil)

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Under Construction"
                                                            message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* gotItButton = [UIAlertAction
                                actionWithTitle:@"Got It!"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    [alert addAction:gotItButton];

    [self.navigationController presentViewController:alert animated:TRUE completion:^{
        self.subContentLabel.text = message;
    }];
}

@end
