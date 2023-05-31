//
//  BaseDataModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import CoreData

protocol BaseDataModel where Self: NSManagedObject {
    func save()
    func delete()
    static func all<T: NSManagedObject>() -> [T]
}

extension BaseDataModel {

    static var context: NSManagedObjectContext {
        return StorageManager.shared.viewContext
    }

    func delete() {
        Self.context.delete(self)
        save()
    }

    func save() {
        do {
            try Self.context.save()
        } catch {
            print(error)
            Self.context.rollback()
        }
    }

    static func byID<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
        do {
            return try context.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
    }

    static func all<T>() -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}

//MARK: - Data Models Extended

extension ExpenseEntity: BaseDataModel {}

extension IntervalEntity: BaseDataModel {}


