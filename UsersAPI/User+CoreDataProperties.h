//
//  User+CoreDataProperties.h
//  UsersAPI
//
//  Created by Elsa Filippidou on 19/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Address.h"
#import "Company.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userEmail;
@property (nullable, nonatomic, retain) NSNumber *userID;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *userLastname;
@property (nullable, nonatomic, retain) NSString *userPhone;
@property (nullable, nonatomic, retain) NSString *userUsername;
@property (nullable, nonatomic, retain) NSString *userWebsite;
@property (nullable, nonatomic, retain) Address *userAddress;
@property (nullable, nonatomic, retain) Company *userCompany;

@end

NS_ASSUME_NONNULL_END
