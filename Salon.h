//
//  Salon.h
//  PolyDoc
//
//  Created by Heidan on 13/03/2014.
//  Copyright (c) 2014 FONTAINE CLAUDIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pool;

@interface Salon : NSManagedObject

@property (nonatomic, retain) NSDate * date_salon;
@property (nonatomic, retain) NSString * lieu_salon;
@property (nonatomic, retain) NSString * title_salon;
@property (nonatomic, retain) NSSet *pools;
@end

@interface Salon (CoreDataGeneratedAccessors)

- (void)addPoolsObject:(Pool *)value;
- (void)removePoolsObject:(Pool *)value;
- (void)addPools:(NSSet *)values;
- (void)removePools:(NSSet *)values;

@end
