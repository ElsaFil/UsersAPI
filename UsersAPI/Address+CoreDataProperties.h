//
//  Address+CoreDataProperties.h
//  UsersAPI
//
//  Created by Elsa Filippidou on 19/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *coordLat;
@property (nullable, nonatomic, retain) NSString *coordLon;
@property (nullable, nonatomic, retain) NSString *street;
@property (nullable, nonatomic, retain) NSString *suite;
@property (nullable, nonatomic, retain) NSString *zipcode;
@property (nullable, nonatomic, retain) NSSet<User *> *tenant;

@end

@interface Address (CoreDataGeneratedAccessors)

- (void)addTenantObject:(User *)value;
- (void)removeTenantObject:(User *)value;
- (void)addTenant:(NSSet<User *> *)values;
- (void)removeTenant:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
