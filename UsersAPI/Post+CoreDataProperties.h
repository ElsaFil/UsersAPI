//
//  Post+CoreDataProperties.h
//  UsersAPI
//
//  Created by Elsa Filippidou on 20/03/16.
//  Copyright © 2016 Elsa Filippidou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *postID;
@property (nullable, nonatomic, retain) NSNumber *postUserID;
@property (nullable, nonatomic, retain) NSString *postTitle;
@property (nullable, nonatomic, retain) NSString *postBody;

@end

NS_ASSUME_NONNULL_END
