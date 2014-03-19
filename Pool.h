//
//  Pool.h
//  PolyDoc
//
//  Created by Heidan on 13/03/2014.
//  Copyright (c) 2014 FONTAINE CLAUDIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Document, Salon;

@interface Pool : NSManagedObject

@property (nonatomic, retain) NSString * student_background;
@property (nonatomic, retain) NSString * student_email;
@property (nonatomic, retain) NSString * student_lastname;
@property (nonatomic, retain) NSString * student_name;
@property (nonatomic, retain) NSSet *documents;
@property (nonatomic, retain) Salon *salon;
@end

@interface Pool (CoreDataGeneratedAccessors)

- (void)addDocumentsObject:(Document *)value;
- (void)removeDocumentsObject:(Document *)value;
- (void)addDocuments:(NSSet *)values;
- (void)removeDocuments:(NSSet *)values;

@end
