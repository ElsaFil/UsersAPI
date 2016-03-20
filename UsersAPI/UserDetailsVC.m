//
//  UserDetailsVC.m
//  UsersAPI
//
//  Created by Elsa Filippidou on 19/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "UserDetailsVC.h"
#import "UserActionsVC.h"

@interface UserDetailsVC ()

@end

@implementation UserDetailsVC

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = _currentUser.userName;
    
    _theUsernameLabel.text = _currentUser.userUsername;
    _theIDLabel.text = [NSString stringWithFormat:@"%@", _currentUser.userID];
    _theCompanyLabel.text = _currentUser.userCompany.compName;
    
    NSString *addressString = [NSString stringWithFormat:@"%@, %@, %@, %@", _currentUser.userAddress.street, _currentUser.userAddress.suite, _currentUser.userAddress.zipcode, _currentUser.userAddress.city];
    [_websiteButton setTitle:_currentUser.userWebsite forState:UIControlStateNormal];
    [_addressButton setTitle:addressString forState:UIControlStateNormal];
    [_emailButton setTitle:_currentUser.userEmail forState:UIControlStateNormal];
    [_phoneButton setTitle:_currentUser.userPhone forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToWebsite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", _currentUser.userWebsite]]];
}

- (IBAction)goToAddress:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/?q=%@,%@",_currentUser.userAddress.coordLat, _currentUser.userAddress.coordLon]]];
}

- (IBAction)sendMail:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", _currentUser.userEmail]]];
}

- (IBAction)callPhonenumber:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString stringWithFormat:@"tel:%@", _currentUser.userPhone] stringByRemovingPercentEncoding]]];
}

- (IBAction)showAction:(id)sender {
    [self performSegueWithIdentifier:@"goToUserActions" sender:sender];
}


#pragma mark - Navigation

// return from user actions page
- (IBAction)returnToUser:(UIStoryboardSegue *)unwindSegue {
    
    UserActionsVC *userActionsPage = [[UserActionsVC alloc]init];
    userActionsPage = unwindSegue.sourceViewController;
    self.currentUser = userActionsPage.currentUser;
    self.managedObjectContext = userActionsPage.managedObjectContext;
}
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // go to user actions page, define if should show posts, albums or to-do's and pass current user
    if ([segue.identifier isEqualToString:@"goToUserActions"]) {
        UserActionsVC *userActionPage = [[UserActionsVC alloc]init];
        userActionPage = segue.destinationViewController;
        userActionPage.managedObjectContext = self.managedObjectContext;
        userActionPage.currentUser = self.currentUser;
        
        if (sender == _postsButton) {
            userActionPage.action = @"posts";
        } else if (sender == _albumsButton) {
            userActionPage.action = @"albums";
        } else if (sender == _albumsButton) {
            userActionPage.action = @"todos";
        }
    }
}


@end
