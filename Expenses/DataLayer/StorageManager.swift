//
//  StorageManager.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import CoreData

protocol StorageManagerType {
    func save()
}

class StorageManager: StorageManagerType {

    let persistentContainer: NSPersistentContainer
    static let shared = StorageManager()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error)
            viewContext.rollback()
        }
    }
}
