//
//  StorageService.swift
//  Expenses
//
//  Created by Gene Dimitrow on 30.05.2023.
//

import Foundation
import CoreData

protocol StorageServiceType {

    func isUserHasData() -> Bool
    func fetchAllIntervals() -> [Interval]
    func fetchCurrentInterval() -> Interval?
    func createRecord()
    func updateRecord()
    func deleteRecord()
    func createInterval(_ interval: Interval)
    func updateInterval(_ interval: Interval)
    func deleteInterval(_ interval: Interval)
}

class StorageService: StorageServiceType {

    private let storageManager: StorageManager
    private let context: NSManagedObjectContext
    private let storageMapper: StorageMapperType

    init(storageManager: StorageManager,
         storageMapper: StorageMapperType) {
        self.storageManager = storageManager
        self.context = storageManager.persistentContainer.viewContext
        self.storageMapper = storageMapper
    }

    func isUserHasData() -> Bool {

        return !(IntervalEntity.all() as [IntervalEntity]).isEmpty
    }

    func fetchAllIntervals() -> [Interval] {

        let intervals: [IntervalEntity] = IntervalEntity.all()
        return []
    }

    func fetchCurrentInterval() -> Interval? {

        return nil
    }

    func createRecord() {

    }

    func updateRecord() {

    }

    func deleteRecord() {

    }

    func createInterval(_ interval: Interval) {

        let entity = storageMapper.mapIntervalModelToEntity(interval)
        storageManager.save()
    }

    func updateInterval(_ interval: Interval) {

    }

    func deleteInterval(_ interval: Interval) {

    }
}


