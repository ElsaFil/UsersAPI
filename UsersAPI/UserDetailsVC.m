//
//  UserDetailsVC.m
//  UsersAPI
//
//  Created by Elsa Filippidou on 19/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "UserDetailsVC.h"

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
    
    _thePhoneLabel.text = _currentUser.userPhone;
    _theMailLabel.text = _currentUser.userEmail;
    
    NSString *addressString = [NSString stringWithFormat:@"%@, %@, %@, %@", _currentUser.userAddress.street, _currentUser.userAddress.suite, _currentUser.userAddress.zipcode, _currentUser.userAddress.city];
    [_websiteButton setTitle:_currentUser.userWebsite forState:UIControlStateNormal];
    [_addressButton setTitle:addressString forState:UIControlStateNormal];
    
    // getData
    // here, not in previous view controller, to miminize the work load
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getData {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goToWebsite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", _currentUser.userWebsite]]];
}

- (IBAction)goToAddress:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/?q=%@,%@",_currentUser.userAddress.coordLat, _currentUser.userAddress.coordLon]]];
}

@end
