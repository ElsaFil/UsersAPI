//
//  UserActionsVC.h
//  UsersAPI
//
//  Created by Elsa Filippidou on 20/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "User.h"

@interface UserActionsVC : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) User *currentUser;

@property (weak, nonatomic) NSString *action;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
