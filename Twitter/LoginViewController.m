//
//  LoginViewController.m
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    // TODO:  The BDBOAuth1RequestOperationManager had different signature than BDBOAuth1SessionManager
    //[[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/request_token" method:@"GET" requestToken:[NSURL URLWithString:@"cptwitterdemo:/oauth"] success:^(BDBOAuth1Credential *accessToken) {

    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/request_token" method:@"GET" requestToken:[NSURL URLWithString:@"cptwitterdemo:/oauth"] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Success - got the request token!");
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the request token!");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
