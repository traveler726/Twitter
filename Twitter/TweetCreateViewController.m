//
//  TweetCreateViewController.m
//  Twitter
//
//  Created by Jennifer Beck on 2/2/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "TweetCreateViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView
#import "AppNavigationalManager.h"
#import "TwitterClient.h"
#import "UIUtils.h"
#import "JsonUtil.h"

@interface TweetCreateViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UITextField *createTextField;

@end

@implementation TweetCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self reloadData];
    // Do any additional setup after loading the view from its nib.
}
- (void) loadUser:(User *) user {
    self.user = user;
    [self reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadData {
    NSLog(@"Will be reloading the data for the Create Tweet View");
    
    if (self.user == nil) {
        self.nameLabel.text = @"ERROR - Unknown User";
        self.handleLabel.text = nil;
        self.profileImageView.hidden = YES;
    } else {
        self.nameLabel.text = self.user.name;
        self.handleLabel.text = self.user.handle;
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
    // Setup NavBar items now.
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Tweet"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(onTweetButton:)];
    self.navigationItem.rightBarButtonItem = tweetButton;

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Cancel"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(onCancelButton:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}


- (IBAction) onTweetButton :(id)sender {
    [[TwitterClient sharedInstance] createTweet:self.createTextField.text withCompletion:^(id responseObject, NSError *error) {
        if ((responseObject != nil) && (error == nil)) {
            //[JsonUtil jsonStringFromDictionary:responseObject logToConsole:YES logPrefix:@"\n\n\nJSON Create Response\n\n\n"];
            NSString *msgText = [NSString stringWithFormat:@"Created the tweet: %@", self.createTextField.text];
            NSLog(@"%@", msgText);
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msgText = [NSString stringWithFormat:@"ERROR: Creating the tweet: %@", self.createTextField.text];
            [UIUtils messageToUser:msgText forNavController:self.navigationController];
            NSLog(@"%@", msgText);
        }
    }];
}

- (IBAction) onCancelButton :(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
