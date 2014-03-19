//
//  CoreDataFacade.m
//  PolyDoc
//
//  Created by Heidan on 13/03/2014.
//  Copyright (c) 2014 FONTAINE CLAUDIN. All rights reserved.
//

#import "CoreDataFacade.h"

@implementation CoreDataFacade

//Utilisé pour "attraper" le managedObjectContext  (simplifie la suite)
+ (NSManagedObjectContext*) managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


/*************
 DEPARTEMENTS
*************/


//Renvois tous les départements
+(NSArray*) loadAllDepartement{
    
    NSArray* departements;
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Departement" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    //NSManagedObject *matches = nil;
    
    NSError *error;
    departements = [[self managedObjectContext] executeFetchRequest:request error:&error]; //on stock les départements
    
    //Si aucun département n'est répertorié
    if ([departements count]==0){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Aucun département enregistré" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorAlertView show];
    }
    
    else {
        //On trie les départements par ordre alphabetique
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"libelle_dpt" ascending:YES];
        departements=[departements sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    }
    return departements;
}


//regarde si le département existe déjà dans coredata
+(BOOL)departementExists:(NSString*) id_dpt
{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Departement" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(id_dpt == %@)",id_dpt];
    [request setPredicate:pred];
    
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *result = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if ([result count]==0) {
        return NO;
    }
    else return YES;
}


//enregistre un département dans coredata
+ (BOOL)saveDepartement:(NSString*)acronyme libelle:(NSString*) libelle{
    NSManagedObjectContext *context = [self managedObjectContext];
    Departement *newDepartement;
    newDepartement = [NSEntityDescription insertNewObjectForEntityForName:@"Departement" inManagedObjectContext:context];
    newDepartement.id_dpt = acronyme;
    newDepartement.libelle_dpt = libelle;
    
    NSError *error=nil;
    
    //Sauvegarde dans coreData
    if(![context save:&error]){
        return NO;
         NSLog(@"%@",error);
    }
    else return TRUE;
}

//attrape le departement dont l'id est donné en paramètre, nil si pas dans coredata
+(Departement*)catchDepartement:(NSString*)id_dpt {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Departement" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(id_dpt == %@)",id_dpt];
    [request setPredicate:pred];
    
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    //si le département est bien trouvé
    if ([results count]!=0){ 
        return [results objectAtIndex:0]; //On prend le premier résultat (unique)

    }
    
    else return nil;
    
}




/*************
 DOCUMENTS
 *************/


//charge les documents au département fournis
+(NSArray*) loadAllDocuments:(NSString*) id_dpt
{
    NSArray* documents;
    Departement* current_dpt = [self catchDepartement:id_dpt];
    documents = [current_dpt.documents allObjects]; //On prend tous les documents
        
    //On trie les documents par ordre alphabetique
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title_doc" ascending:YES];
    documents=[documents sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    return documents;
}

//charge les documents de la pool fournis
+(NSArray*) loadAllDocumentsFromPool:(NSManagedObjectID*) pool_id
{
    Pool* current_pool = ((Pool*)[[self managedObjectContext] objectRegisteredForID:pool_id]);
    NSArray* documents;
    documents = [current_pool.documents allObjects]; //On prend tous les documents
    
    //On trie les documents par ordre alphabetique
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title_doc" ascending:YES];
    documents=[documents sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    return documents;
}


+(BOOL)saveDocument:(NSString*)title_doc url :(NSString*)url_doc departement:(NSString*) id_dpt
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    Document *newDocument;
    newDocument = [NSEntityDescription insertNewObjectForEntityForName:@"Document" inManagedObjectContext:context];
    newDocument.title_doc=title_doc;
    newDocument.url_doc=url_doc;
    
    //Assignation au département courant :
    [newDocument setValue:[self catchDepartement:id_dpt] forKey:@"departement"];
    NSError *error=nil;
    
    //Sauvegarde dans coreData
    if(![context save:&error]){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Erreur lors de l'enregistrement" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        NSLog(@"%@",error);
        [errorAlertView show];
        return NO;
    }
    
    else return YES;
    //sinon on affiche une erreur
    
    
}





/*************
 SALONS
 *************/

+(NSArray*)loadAllSalons
{
    NSArray* salons;
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Salon" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    //NSManagedObject *matches = nil;
    
    NSError *error;
    salons = [[self managedObjectContext] executeFetchRequest:request error:&error]; //on stock les salons
    
    
    if([salons count]!=0){
        //On trie les salons par ordre alphabetique
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date_salon" ascending:NO];
        salons=[salons sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    }
    
    return salons;
}

+(BOOL)saveSalon:(NSString*) title_salon location:(NSString*)lieu_salon date:(NSDate*) date_salon
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Salon *newSalon;
    newSalon = [NSEntityDescription insertNewObjectForEntityForName:@"Salon" inManagedObjectContext:context];
    
    //remplissage du NSManaged Object avec les paramètres
    newSalon.title_salon=title_salon;
    newSalon.lieu_salon=lieu_salon;
    newSalon.date_salon=date_salon;
    
    
    NSError* erreur=nil;
    
    //on sauvegarde dans le .sqlite, si la sauvegarde échoue une dialogbox apparait
    if(![context save:&erreur]){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Erreur lors de l'enregistrement" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        NSLog(@"%@",erreur);
        [errorAlertView show];
        return NO;
    }
    else return YES;
}

//attrape le salon correspondant à l'ID
+(Salon*) catchSalon:(NSManagedObjectID*) id_salon{
    Salon* caughtObject=((Salon*)[[self managedObjectContext] objectRegisteredForID:id_salon]);
    
    return caughtObject;
}




/*************
 POOLS
 *************/

+(NSArray*) loadAllPools:(NSManagedObjectID*) id_salon{
    NSArray* pools;
    
    Salon* current_salon = [self catchSalon:id_salon]; //on attrape le salon concerné par l'id en paramètre
    pools = [current_salon.pools allObjects]; // on garde les pools de ce salon pour les renvoyer
    
    return pools;

}




+(BOOL) savePool:(NSString*) nom prenom:(NSString*) prenom adresseMail:(NSString*) mail Provenance:(NSString*) provenance idSalon:(NSManagedObjectID *)id_salon {
    
    Salon* current_salon = [self catchSalon:id_salon];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    Pool *newPool;
    newPool = [NSEntityDescription insertNewObjectForEntityForName:@"Pool" inManagedObjectContext:context];
    
    //remplissage du NSManaged Object avec les paramètres
    newPool.student_lastname=nom;
    newPool.student_name=prenom;
    newPool.student_email=mail;
    newPool.student_background=provenance;
    
    newPool.salon=current_salon;
    
    NSError* erreur=nil;
    
    //on sauvegarde dans le .sqlite, si la sauvegarde échoue une dialogbox apparait
    if(![context save:&erreur]){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Erreur lors de l'enregistrement" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        NSLog(@"%@",erreur);
        [errorAlertView show];
        return NO;
    }
    else return YES;
    
}


+(BOOL) addDocumentToPool:(NSManagedObjectID*) pool_id documentID : (NSManagedObjectID*) doc_id{
    
    NSManagedObjectContext* context = [self managedObjectContext];
    Pool* currentPool = ((Pool*)[context objectRegisteredForID:pool_id]);
    Document* currendDoc = ((Document*)[context objectRegisteredForID:doc_id]);
    
    [currentPool addDocumentsObject:currendDoc];
    
    NSError* erreur;
    //on sauvegarde dans le .sqlite, si la sauvegarde échoue une dialogbox apparait
    if(![context save:&erreur]){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Erreur lors de l'enregistrement" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        NSLog(@"%@",erreur);
        [errorAlertView show];
        return NO;
    }
    else return YES;
}











@end
