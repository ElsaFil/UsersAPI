//
//  UserListVC.m
//  UsersAPI
//
//  Created by Elsa Filippidou on 18/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "UserListVC.h"

@interface UserListVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation UserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = @"Users";
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getData {
    
    NSURL *url = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    // request data, wait until completed, use the data
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                                            NSError *error;
                                            NSArray *userData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                            
                                            // save user info in core data
                                            for (int i=0; i < userData.count; i++) {
                                                
                                            }
                                            
                                            // update UI in main thread
                                            dispatch_sync(dispatch_get_main_queue(), ^{
                                                [_tableView reloadData];
                                            });
                                            
                                        }
                                  ];
    [task resume];
}

# pragma mark - Table View delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1; // change this
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // cell.textLabel.text = ...
    
    return cell;
}

@end
