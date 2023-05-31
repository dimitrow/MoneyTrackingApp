//
//  StorageService.swift
//  Expenses
//
//  Created by Gene Dimitrow on 30.05.2023.
//

import Foundation
import CoreData

protocol StorageServiceType {

    func fetchAllIntervals() -> [Interval]
    func fetchCurrentInterval() -> Interval?
    func createRecord()
    func updateRecord()
    func deleteRecord()
    func createInterval()
    func updateInterval()
    func deleteInterval()
}

class StorageService: StorageServiceType {

    private let storageManager: StorageManager
    private let persistanceContainer: NSPersistentContainer
    private let mapper: ModelMapperType

    init(storageManager: StorageManager, mapper: ModelMapperType) {
        self.storageManager = storageManager
        self.persistanceContainer = storageManager.persistentContainer
        self.mapper = mapper
    }

    func fetchAllIntervals() -> [Interval] {

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

    func createInterval() {

    }

    func updateInterval() {

    }

    func deleteInterval() {

    }
}
