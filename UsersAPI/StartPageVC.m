//
//  StartPageVC.m
//  UsersAPI
//
//  Created by Elsa Filippidou on 19/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//

#import "StartPageVC.h"
#import "UserListVC.h"

@interface StartPageVC ()

@end

@implementation StartPageVC

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"goToUserList"]) {
        UserListVC *nextVC = [[UserListVC alloc]init];
        nextVC = segue.destinationViewController;
        nextVC.managedObjectContext = self.managedObjectContext;
    }
}

- (IBAction)returnToStartPage:(UIStoryboardSegue *)unwindSegue {
    
}

@end
