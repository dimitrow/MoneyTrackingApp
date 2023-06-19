//
//  StorageService.swift
//  Expenses
//
//  Created by Gene Dimitrow on 30.05.2023.
//

import Foundation
import CoreData

typealias SaveCompletion = () -> Void

protocol StorageServiceType {

    func isUserHasData() -> Bool
    func fetchAllIntervals() -> [Interval]
    func fetchCurrentInterval() -> Interval?
    func createRecord()
    func updateRecord()
    func deleteRecord()
    func createInterval(_ interval: Interval, completion: SaveCompletion)
    func updateInterval(_ interval: Interval, completion: SaveCompletion)
    func deleteInterval(_ interval: Interval, completion: SaveCompletion)
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

//        let intervals: [IntervalEntity] = IntervalEntity.all()
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

    func createInterval(_ interval: Interval, completion: SaveCompletion) {
        _ = storageMapper.mapIntervalModelToEntity(interval)
        try? storageManager.save()
        completion()
    }

    func updateInterval(_ interval: Interval, completion: SaveCompletion) {

    }

    func deleteInterval(_ interval: Interval, completion: SaveCompletion) {

    }
}


