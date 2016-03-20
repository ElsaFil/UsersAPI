//
//  UserDetailsVC.h
//  UsersAPI
//
//  Created by Elsa Filippidou on 19/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "User.h"

@interface UserDetailsVC : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) User *currentUser;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *theUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *theCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *thePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *theMailLabel;

@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UIButton *postsButton;
@property (weak, nonatomic) IBOutlet UIButton *albumsButton;
@property (weak, nonatomic) IBOutlet UIButton *todoButton;

- (IBAction)goToWebsite:(id)sender;
- (IBAction)goToAddress:(id)sender;

@end
