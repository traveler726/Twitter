
//
//  LoginViewController.m
//  Twitter
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

#import "AppNavigationalManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    
    // Consolidated implementation: Will pass this completion block to the TwitterClient which will call it back.
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if ( user != nil ) {
            // Modally present tweets view
            NSLog(@"Welcome '%@'", user.name);
            [[AppNavigationalManager sharedObj] userHasLoggedIn];
            
            // [self presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>

        } else {
            // Present error view
            NSLog(@"Login error: %@", error);
        }
    }];
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"login done - popping off navigation stack.");
//    }];
}

- (IBAction)onLogout:(id)sender {
    [[TwitterClient sharedInstance] logoutWithCompletion:^(User *user, NSError *error) {
        if (user == nil) {
            NSLog(@"User has logged out.");
            [[AppNavigationalManager sharedObj] userHasLoggedOut];
        } else {
            NSLog(@"ERROR: Logout Error.  Still signed in as: %@ Error: %@", user.name, error);
        }
        
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
