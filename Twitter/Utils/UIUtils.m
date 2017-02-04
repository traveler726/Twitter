//
//  UIUtils.m
//  Twitter
//
//  Created by Jennifer Beck on 2/3/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils


+ (void) messageToUser:(NSString *) message forNavController:(UINavigationController *) navigationController {
    // Easy way deprecated:
    // [self presentViewController(alertController, animated: true, completion: nil)
    
    if (navigationController != nil) {
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
    
    [navigationController presentViewController:alert animated:TRUE completion:nil];
    } else {
        NSLog(@"ALERT: Under Construction: %@", message);
    }
}


@end
