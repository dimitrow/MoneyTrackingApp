//
//  StorageService.swift
//  Expenses
//
//  Created by Gene Dimitrow on 30.05.2023.
//

import Foundation
import CoreData
import Combine

typealias SaveCompletion = () -> Void

protocol StorageOutput {
    var intervalUpdated: PassthroughSubject<Bool, Never> { get }
    func isUserHasActiveData() -> Bool
    func isUserHasData() -> Bool
    func fetchAllIntervals() -> [Interval]
    func fetchCurrentInterval() -> Interval
    func fetchLastInterval() throws -> Interval
}

protocol StorageInput {
    func createRecord(_ expense: Expense)
    func updateRecord()
    func deleteRecord()
    func createInterval(_ interval: Interval, completion: SaveCompletion)
    func updateInterval(_ interval: Interval, completion: SaveCompletion)
    func deleteInterval(_ interval: Interval, completion: SaveCompletion)
}

protocol StorageServiceType: StorageInput, StorageOutput { }

class StorageService: StorageServiceType {

    private let storageManager: StorageManager
    private let context: NSManagedObjectContext
    private let storageMapper: StorageMapperType

    var intervalUpdated = PassthroughSubject<Bool, Never>()

    init(storageManager: StorageManager,
         storageMapper: StorageMapperType) {
        self.storageManager = storageManager
        self.context = storageManager.persistentContainer.viewContext
        self.storageMapper = storageMapper
    }

    func fetchLastInterval() throws -> Interval {
        let userIntervals: [IntervalEntity] = IntervalEntity.all()
        guard let interval = userIntervals
            .map({storageMapper.mapIntervalEntityToModel($0)})
            .sorted(by: {$0.timeStamp > $1.timeStamp})
            .first else {
            throw AppError.missingIntervalData
        }
        return interval
    }

    func isUserHasData() -> Bool {
        do {
            _ = try fetchLastInterval()
            return true
        } catch {
            return false
        }
    }

    func isUserHasActiveData() -> Bool {
        do {
            let interval = try fetchLastInterval()
            return interval.endDate.compare(.isInTheFuture)
        } catch {
            return false
        }
    }

    func fetchAllIntervals() -> [Interval] {

//        guard let intervals: [IntervalEntity] = IntervalEntity.all() else {
//
//            return []
//        }
        return []
    }

    func fetchCurrentInterval() -> Interval {

        do {
            return try fetchLastInterval()
        } catch {
            fatalError()
        }
    }

    func createRecord(_ expense: Expense) {
        _ = storageMapper.mapExpenseModelToEntity(expense)
        try? storageManager.save()
        intervalUpdated.send(true)
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


