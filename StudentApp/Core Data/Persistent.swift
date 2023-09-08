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
        container = NSPersistentContainer(name: "Models")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
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
    
    func getLessonNameEntityArray() -> [LessonName]? {
        do {
            let fetchRequest: NSFetchRequest<LessonName> = LessonName.fetchRequest()
            let objects = try PersistenceController.shared.context.fetch(fetchRequest)
            
            return objects
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

