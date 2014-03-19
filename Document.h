//
//  Document.h
//  PolyDoc
//
//  Created by Heidan on 13/03/2014.
//  Copyright (c) 2014 FONTAINE CLAUDIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Departement, Pool;

@interface Document : NSManagedObject

@property (nonatomic, retain) NSString * title_doc;
@property (nonatomic, retain) NSString * url_doc;
@property (nonatomic, retain) Departement *departement;
@property (nonatomic, retain) NSSet *pools;
@end

@interface Document (CoreDataGeneratedAccessors)

- (void)addPoolsObject:(Pool *)value;
- (void)removePoolsObject:(Pool *)value;
- (void)addPools:(NSSet *)values;
- (void)removePools:(NSSet *)values;

@end
