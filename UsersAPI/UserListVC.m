//
//  UserListVC.m
//  UsersAPI
//
//  Created by Elsa Filippidou on 18/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "UserListVC.h"
#import "User.h"
#import "Address.h"
#import "Company.h"
#import "UserDetailsVC.h"

@interface UserListVC () <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *usersArray;
    NSInteger indexForUser;
}

@end

@implementation UserListVC

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = @"Users";
    
    _usersLabel.text = @"Total users: ";
    _usersCountLabel.text = @"0";
    
    [_loadingLabel setHidden:TRUE];
    [_loadingSpin setHidden:TRUE];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // check if previous data exists
    [self updateListOfUsers];
    
    // no previous data, get data from API
    if (usersArray.count == 0) {
        // show loading indicator
        [_usersLabel setHidden:TRUE];
        [_usersCountLabel setHidden:TRUE];
        [_loadingLabel setHidden:FALSE];
        [_loadingSpin setHidden:FALSE];
        [_loadingSpin startAnimating];
        
        [self getData];
    }
    
    [_usersLabel setHidden:FALSE];
    [_usersCountLabel setHidden:FALSE];
    _usersCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)usersArray.count];
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
                                            
                                            // break down API data
                                            for (int i=0; i < userData.count; i++) {
                                                NSDictionary *aUser = [userData objectAtIndex:i];
                                                
                                                // setup Address and Company
                                                Address *nAddress = [self setupAddress:[aUser objectForKey:@"address"]];
                                                Company *nCompany = [self setupCompany:[aUser objectForKey:@"company"]];
                                                
                                                User *nUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
                                                
                                                // setup user info
                                                nUser.userName = [aUser objectForKey:@"name"];
                                                nUser.userUsername = [aUser objectForKey:@"username"];
                                                nUser.userID = [aUser objectForKey:@"id"];
                                                nUser.userEmail = [aUser objectForKey:@"email"];
                                                nUser.userWebsite = [aUser objectForKey:@"website"];
                                                nUser.userPhone = [aUser objectForKey:@"phone"];
                                                nUser.userAddress = nAddress;
                                                nUser.userCompany = nCompany;
                                                
                                                // save in Core Data
                                                if (![self.managedObjectContext save:&error]) {
                                                    NSLog(@"Couldn't save with error: %@", [error localizedDescription]);
                                                }
                                                
                                            }
                                            
                                            // update array with users
                                            [self updateListOfUsers];
                                            
                                            // update UI in main thread
                                            dispatch_sync(dispatch_get_main_queue(), ^{
                                                
                                                [_loadingLabel setHidden:TRUE];
                                                [_loadingSpin setHidden:TRUE];
                                                [_loadingSpin stopAnimating];
                                                
                                                [_tableView reloadData];
                                                
                                                [_usersLabel setHidden:FALSE];
                                                [_usersCountLabel setHidden:FALSE];
                                                _usersCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)usersArray.count];
                                            });
                                            
                                        }
                                  ];
    [task resume];
}

- (Address*) setupAddress:(NSDictionary *)dict {
    Address *nAddress = [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:self.managedObjectContext];
    nAddress.street = [dict objectForKey:@"street"];
    nAddress.suite = [dict objectForKey:@"suite"];
    nAddress.city = [dict objectForKey:@"city"];
    nAddress.zipcode = [dict objectForKey:@"zipcode"];
    
    nAddress.coordLat = [[dict objectForKey:@"geo"] objectForKey:@"lat"];
    nAddress.coordLon = [[dict objectForKey:@"geo"] objectForKey:@"lng"];
    
    return nAddress;
}

- (Company*) setupCompany:(NSDictionary *)dict {
    Company *nCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    nCompany.compName = [dict objectForKey:@"name"];
    nCompany.compPhrase = [dict objectForKey:@"catchPhrase"];
    nCompany.compBs = [dict objectForKey:@"bs"];
    
    return nCompany;
}

- (void) updateListOfUsers {
    
    usersArray = nil;
    
    // get list of Users
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    usersArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    
    // sort array alphabetically
    [usersArray sortUsingComparator:^(User *a, User *b) {
        return [a.userName compare:b.userName];
    }];
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
    
    if (usersArray.count >= indexPath.row) {
        User *userForRow = [usersArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", userForRow.userName];
    } else {
        cell.textLabel.text = @"no user data";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    indexForUser = indexPath.row;
    
    [self performSegueWithIdentifier:@"goToUserDetails" sender:self];
}

# pragma mark - Navigation

- (IBAction)returnToUserList:(UIStoryboardSegue *)unwindSegue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToUserDetails"]) {
        UserDetailsVC *detailsVC = [[UserDetailsVC alloc] init];
        detailsVC = segue.destinationViewController;
        detailsVC.currentUser = [usersArray objectAtIndex:indexForUser];
        detailsVC.managedObjectContext = self.managedObjectContext;
    }
}

@end
