//
//  Persistent.swift
//  StudentApp
//
//  Created by Fadey Notchenko on 08.09.2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    var context: NSManagedObjectContext { self.container.viewContext }

    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "Models")
        
        if inMemory {
            self.container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        self.container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext () {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                self.context.rollback()
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchObjects<T: NSManagedObject>(entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors

        do {
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch {
            print("Fetch error: \(error.localizedDescription)")
            
            return nil
        }
    }

}

