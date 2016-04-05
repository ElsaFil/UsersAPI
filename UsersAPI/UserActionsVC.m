//
//  UserActionsVC.m
//  UsersAPI
//
//  Created by Elsa Filippidou on 20/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "UserActionsVC.h"
#import "Post.h"
#import "CustomCellTVC.h"

@interface UserActionsVC () <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *itemsArray;
}

@end

@implementation UserActionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = _currentUser.userName;
    _loadingLabel.hidden = TRUE;
    _loadingSpin.hidden = TRUE;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // check if previous data exists - gets only posts for current user
    [self updateItemList];
    
    // no previous data, get data from API
    if (itemsArray.count == 0) {
        if ([_action isEqualToString:@"posts"]) {
            
            _subtitleLabel.text = @"Posts";
            
            _loadingLabel.hidden = FALSE;
            _loadingSpin.hidden = FALSE;
            [_loadingSpin startAnimating];
            
            [self getDataPosts];
        }
        else if ([_action isEqualToString:@"albums"]) {
            _subtitleLabel.text = @"Albums";
        }
        else if ([_action isEqualToString:@"todos"]) {
            _subtitleLabel.text = @"To-Dos";
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getDataPosts {
    NSURL *url = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/posts"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    // request data (all posts for all users), wait until completed, use the data
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                                            NSError *error;
                                            NSArray *postData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                            
                                            // break down API data
                                            // (carefull: gets all posts for all users)
                                            for (int i=0; i < postData.count; i++) {
                                                NSDictionary *aPost = [postData objectAtIndex:i];
                                                
                                                Post *nPost = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:self.managedObjectContext];
                                                
                                                // setup user info
                                                nPost.postID = [aPost objectForKey:@"id"];
                                                nPost.postUserID = [aPost objectForKey:@"userId"];
                                                nPost.postTitle = [aPost objectForKey:@"title"];
                                                nPost.postBody = [aPost objectForKey:@"body"];
                                                
                                                // save in Core Data
                                                if (![self.managedObjectContext save:&error]) {
                                                    NSLog(@"Couldn't save with error: %@", [error localizedDescription]);
                                                }
                                            }
                                            
                                            // update array with posts for current user
                                            [self updateItemList];
                                            
                                            // update UI in main thread
                                            dispatch_sync(dispatch_get_main_queue(), ^{
                                                
                                                [_loadingLabel setHidden:TRUE];
                                                [_loadingSpin setHidden:TRUE];
                                                [_loadingSpin stopAnimating];
                                                
                                                [_tableView reloadData];
                                                
                                                // show number of posts in subtitle
                                                _subtitleLabel.text = [NSString stringWithFormat:@"%lu Posts",(unsigned long)itemsArray.count];
                                            });
                                            
                                        }
                                  ];
    [task resume];
}

- (void) updateItemList {
    itemsArray = [[NSMutableArray alloc]init];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSError *error;
    
    if ([_action isEqualToString:@"posts"]) {
        
        _subtitleLabel.text = @"Posts";
        
        // get list of Posts
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        NSArray *tempArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:&error]];
        
        // save posts for current user only
        for (Post *aPost in tempArray) {
            if ([aPost.postUserID isEqualToNumber:_currentUser.userID]) {
                [itemsArray addObject:aPost];
            }
        }
        
        // sort array by post ID
        [itemsArray sortUsingComparator:^(Post *a, Post *b) {
            return [a.postID compare:b.postID];
        }];
    }
    else if ([_action isEqualToString:@"albums"]) {
        _subtitleLabel.text = @"Albums";
    }
    else if ([_action isEqualToString:@"todos"]) {
        _subtitleLabel.text = @"To-Dos";
    }    
    
}

# pragma mark - Table View delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (itemsArray.count) {
        return itemsArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCellTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell"];
    
    if (itemsArray.count >= indexPath.row) {
        Post *postForRow = [itemsArray objectAtIndex:indexPath.row];
        cell.titleLabel.text = postForRow.postTitle;
        cell.contentLabel.text = postForRow.postBody;
    } else {
        cell.titleLabel.text = @"no data found";
    }
    
    return cell;
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
