//
//  UserListVC.m
//  UsersAPI
//
//  Created by Elsa Filippidou on 18/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "UserListVC.h"
#import "User.h"

@interface UserListVC () <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *usersArray;
}

@end

@implementation UserListVC

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = @"Users";
    
    [_loadingLabel setHidden:TRUE];
    [_loadingSpin setHidden:TRUE];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // check if previous data exists
    [self updateListOfUsers];
    
    if (usersArray.count == 0) {
        
        // no previous data, get data from API
        // show loading indicator
        [_loadingLabel setHidden:FALSE];
        [_loadingSpin setHidden:FALSE];
        [_loadingSpin startAnimating];
        
        [self getData];
    }
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
                                                NSDictionary *aUser = [userData objectAtIndex:i];
                                                User *nUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
                                                nUser.userName = [aUser objectForKey:@"name"];
                                                nUser.userUsername = [aUser objectForKey:@"username"];
                                                nUser.userID = [aUser objectForKey:@"id"];
                                                nUser.userEmail = [aUser objectForKey:@"email"];
                                                nUser.userWebsite = [aUser objectForKey:@"website"];
                                                nUser.userPhone = [aUser objectForKey:@"phone"];
                                                
                                                if (![self.managedObjectContext save:&error]) {
                                                    NSLog(@"Whoops, couldn't save badges: %@", [error localizedDescription]);
                                                }
                                                
                                            }
                                            
                                            [self updateListOfUsers];
                                            
                                            // update UI in main thread
                                            dispatch_sync(dispatch_get_main_queue(), ^{
                                                
                                                [_loadingLabel setHidden:TRUE];
                                                [_loadingSpin setHidden:TRUE];
                                                [_loadingSpin startAnimating];
                                                
                                                [_tableView reloadData];
                                            });
                                            
                                        }
                                  ];
    [task resume];
}

- (void) updateListOfUsers {
    
    usersArray = nil;
    
    // get list of Users
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    usersArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"number of users: %lu", (unsigned long)usersArray.count);
}

# pragma mark - Table View delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (usersArray.count) {
        return usersArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BasicCell"];
    
    if (usersArray) {
        User *userForRow = [usersArray objectAtIndex:indexPath.row];
        cell.textLabel.text = userForRow.userName;
    } else {
        cell.textLabel.text = @"no user data";
    }
    
    
    return cell;
}

@end
