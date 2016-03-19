//
//  Company+CoreDataProperties.h
//  UsersAPI
//
//  Created by Elsa Filippidou on 19/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Company.h"

NS_ASSUME_NONNULL_BEGIN

@interface Company (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *compBs;
@property (nullable, nonatomic, retain) NSString *compName;
@property (nullable, nonatomic, retain) NSString *compPhrase;
@property (nullable, nonatomic, retain) NSSet<User *> *employee;

@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(User *)value;
- (void)removeEmployeeObject:(User *)value;
- (void)addEmployee:(NSSet<User *> *)values;
- (void)removeEmployee:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
