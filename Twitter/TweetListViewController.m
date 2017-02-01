//
//  TweetListViewController.m
//  TwitterDemo
//
//  Created by Jennifer Beck on 1/30/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"

@interface TweetListViewController ()  <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *viewTable;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    // NOTE: Hiding a view with auto-layout does not really work.  The view will hide but the
    //       layout constraints will still be in effect.  So the layout will leave the spot for the view.
    //       So instead need to set a constraint to 0 to get rid of.
    if (indexPath.row % 5) {
        cell.retweetContainerHeightContraint.constant = 30; // 24 * indexPath.row;

    } else {
        cell.retweetContainerHeightContraint.constant = 0;
    }
    [cell setNeedsUpdateConstraints];
    
    cell.rowCount = indexPath.row;
    
    return cell;
}

@end
