//
//  UserProfileViewController.m
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "UserProfileViewController.h"
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
    // Do any additional setup after loading the view from its nib.
    if (self.user == nil) {
        // Should this force a login?
    }
    [self reloadData];
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
        self.subContentLabel.text = @"ERROR";
        self.profileImageView.hidden = YES;
    } else {
        self.nameLabel.text = self.user.name;
        self.handleLabel.text = self.user.screenname;
        self.descriptionLabel.text = self.user.tagline;
        self.followingCountLabel.text = self.user.followingCount;
        self.followerCountLabel.text = self.user.followersCount;
        self.subContentLabel.text = @"Coming Soon";
        [self.profileImageView setImageWithURL:self.user.profileImageUrl];
        self.profileImageView.hidden = YES;
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

@end
