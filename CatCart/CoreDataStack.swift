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
       let newContainer = NSPersistentContainer(name: "CatCart")
        newContainer.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("Failed to load persistent stores: \(error!)")
            }
        }
        return newContainer
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
