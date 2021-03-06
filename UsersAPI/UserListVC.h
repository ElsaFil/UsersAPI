//
//  UserListVC.h
//  UsersAPI
//
//  Created by Elsa Filippidou on 18/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//


@interface UserListVC : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpin;
@property (weak, nonatomic) IBOutlet UILabel *usersLabel;
@property (weak, nonatomic) IBOutlet UILabel *usersCountLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

