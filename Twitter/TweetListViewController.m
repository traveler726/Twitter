//
//  TweetListViewController.m
//  TwitterDemo
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "AppNavigationalManager.h"
#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "UIUtils.h"

@interface TweetListViewController ()  <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *viewTable;
@property (strong, nonatomic) NSArray<Tweet *> *tweets;

// Refresh controls
@property (strong, nonatomic) UIRefreshControl *refreshTableControl;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupRefresh];
    [self.viewTable setDelegate:self];
    
    [self getData];
    [self.viewTable reloadData];
    
    self.viewTable.dataSource = self;
    self.viewTable.estimatedRowHeight = 200;
    self.viewTable.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    
    [self.viewTable registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getData {
    
   // self.tweets = [[TwitterClient sharedInstance] getTweets];
    
    // ToDo move all access to Twitter via the Client.
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSUInteger count = [responseObject count];
        NSLog(@"Successful getting %ld Tweets (via home_timeline)", count);

        self.tweets = [Tweet tweetsWithArray:responseObject];
        [self.viewTable reloadData];
        int tweetCount = 0;
        for (Tweet *tweet in self.tweets) {
            NSLog(@" %d Tweet createdAt: %@ text: %@", tweetCount, tweet.createdAt, tweet.text);
            tweetCount += 1;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog (@"Error getting tweets");
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (TweetTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    if (self.tweets.count > indexPath.row) {
        cell.tweet = [self.tweets objectAtIndex:indexPath.row];
        cell.hidden = NO;
    } else {
        // TODO: Need to set the constraint to make sure the cell does not take up empty space in layout.
        // See below commented out section.
        cell.tweet  = nil;
        cell.hidden = YES;
    }
    [cell reloadData];
    
    // NOTE: Hiding a view with auto-layout does not really work.  The view will hide but the
    //       layout constraints will still be in effect.  So the layout will leave the spot for the view.
    //       So instead need to set a constraint to 0 to get rid of.
//    if (indexPath.row % 5) {
//        cell.retweetContainerHeightContraint.constant = 30; // 24 * indexPath.row;
//
//    } else {
//        cell.retweetContainerHeightContraint.constant = 0;
//    }
//    [cell setNeedsUpdateConstraints];

    return cell;
}

#pragma mark - UIRefreshControl

- (void) setupRefresh {
    UIRefreshControl *refreshTableControl = [[UIRefreshControl alloc] init];
    [refreshTableControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    self.refreshTableControl = refreshTableControl;
    [self.viewTable addSubview:refreshTableControl];
    
}

- (void) refreshControlAction {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSLog(@"Refreshing the data and view @ %@...", [formatter stringFromDate:[NSDate date]]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Your main thread code goes in here
        [self getData];
        [self.viewTable reloadData];
        [self.refreshTableControl endRefreshing];
    });
}

#pragma mark - UITableViewDelegate for cell selection

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *messageText = [NSString stringWithFormat:@"User selected table row for index:%ld", indexPath.row];
//    [UIUtils messageToUser:messageText forNavController:self.navigationController];
    Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    [[AppNavigationalManager sharedObj] pushTweetDetailView:tweet ontoNavWithName:@"HomeTimeLine"];
}

@end
