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

@property (weak, nonatomic) IBOutlet UILabel *theUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *theCompanyLabel;

@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UIButton *postsButton;
@property (weak, nonatomic) IBOutlet UIButton *albumsButton;
@property (weak, nonatomic) IBOutlet UIButton *todoButton;

- (IBAction)goToWebsite:(id)sender;
- (IBAction)goToAddress:(id)sender;
- (IBAction)sendMail:(id)sender;
- (IBAction)callPhonenumber:(id)sender;


@end
