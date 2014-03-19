//
//  CoreDataFacade.h
//  PolyDoc
//
//  Created by Heidan on 13/03/2014.
//  Copyright (c) 2014 FONTAINE CLAUDIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Document.h"
#import "Departement.h"
#import "Pool.h"
#import "Salon.h"

@interface CoreDataFacade : NSObject

//Utilisé pour "attraper" le managedObjectContext  (simplifie la suite)
+ (NSManagedObjectContext *)managedObjectContext;

+ (NSArray*) loadAllDepartement;
+ (BOOL)departementExists:(NSString*) dpt_name;
+ (BOOL)saveDepartement:(NSString*)acronyme libelle:(NSString*) libelle;
+ (Departement*)catchDepartement:(NSString*)id_dpt;


+(NSArray*) loadAllDocuments:(NSString*) id_dpt;
+(BOOL)saveDocument:(NSString*)title_doc url :(NSString*)url_doc departement:(NSString*) id_dpt;
+(NSArray*) loadAllDocumentsFromPool:(NSManagedObjectID*) pool_id;


+(NSArray*)loadAllSalons;
+(BOOL)saveSalon:(NSString*) title_salon location:(NSString*)lieu_salon date:(NSDate*) date_salon;

+(NSArray*) loadAllPools:(NSManagedObjectID*) id_salon;
+(BOOL) savePool:(NSString*) nom prenom:(NSString*) prenom adresseMail:(NSString*) mail Provenance:(NSString*) provenance idSalon : (NSManagedObjectID*)id_salon;
+(BOOL) addDocumentToPool:(NSManagedObjectID*) pool_id documentID : (NSManagedObjectID*) doc_id;



@end
