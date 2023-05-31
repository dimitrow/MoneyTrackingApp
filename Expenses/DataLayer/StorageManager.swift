//
//  StorageManager.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import CoreData

class StorageManager {

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

        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
}
