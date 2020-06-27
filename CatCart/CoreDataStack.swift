//
//  CoreDataStack.swift
//  CatCart
//
//  Created by Christy Hicks on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer = {
       let newContainer = NSPersistentContainer(name: "CatCoreData")
        
        newContainer.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("Failed to load persistent stores: \(error!)")
            }
        }
        newContainer.viewContext.automaticallyMergesChangesFromParent = true
        return newContainer
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var saveError: Error?
        
        context.performAndWait {
            do {
                try context.save()
            } catch {
                saveError = error
                context.reset()
            }
        }
        
        if let saveError = saveError { throw saveError }
    }
    
}
